//
//  TezosService.swift
//  wallet
//
//  Created by Jacky on 2020/10/08.
//

import Foundation
import TezosSwift
import KeychainSwift

public class TezosService: ObservableObject {
    static let shared = TezosService()
    
    @Published var balance:String = "0"
    @Published var isObservationMode = false
    @Published var isWalletLoaded = false
    
    public var wallet:Wallet?
    private let tezos:TezosClient?
    private let keychain = KeychainSwift()

    private init() {
        tezos = TezosClient(remoteNodeURL: Constants.defaultNodeURL)
        isObservationMode = User.pkh.value != nil
        isWalletLoaded = loadLocalWallet()
        fetchBalance()
    }
    
    public func removeWalletFromLocal() {
        isWalletLoaded = false
        balance = ""
        isObservationMode = false
        wallet = nil
        keychain.delete(Constants.keyWalletMnemonic)
        keychain.delete(Constants.keyWalletPassphrase)
    }
    
    public func loadLocalWallet() -> Bool {
        if isObservationMode {
            return true
        }
        if let m = keychain.get(Constants.keyWalletMnemonic), let p = keychain.get(Constants.keyWalletPassphrase) {
            wallet = Wallet(mnemonic: m, passphrase: p)
        }
        
        return wallet != nil
    }
    
    @discardableResult
    public func createWallet(_ password:String) -> Bool {
        if let w = Wallet(passphrase: password), let m = w.mnemonic {
            wallet = w
            keychain.set(m, forKey: Constants.keyWalletMnemonic)
            keychain.set(password, forKey: Constants.keyWalletPassphrase)
            fetchBalance()
            return true
        }
        return false
    }
    
    public func fetchBalance() {
        var addr = ""
        if let pkh = User.pkh.value {
            isObservationMode = true
            addr = pkh
        }else {
            guard let ad = wallet?.address else {
                return
            }
            addr = ad
        }
        
        tezos?.balance(of: addr, completion: { result in
            switch result {
                case .success(let balance):
                    DispatchQueue.main.async {
                        self.balance = balance.humanReadableRepresentation
                    }
                case .failure(let error):
                    print("Getting balance failed with error: \(error)")
                }
        })
    }
    
    private func fetchLatestBlock() {
        tezos?.chainHead { result in
            switch result {
                case .success(let head):
                    print(head.chainId)
                    print(head.protocol)
                case .failure(let error):
                    print("failed with error:\(error)")
                }
        }
    }
}
