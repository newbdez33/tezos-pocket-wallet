//
//  TezosService.swift
//  wallet
//
//  Created by Jacky on 2020/10/08.
//

import Foundation
import TezosSwift

public class TezosService: ObservableObject {
    static let shared = TezosService()
    @Published var balance:String = "0"
    @Published var isObservationMode = false
    @Published var isWalletLoaded = false
    
    public var wallet:Wallet?
    private let tezos:TezosClient?
    

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
    }
    
    public func loadLocalWallet() -> Bool {
        if isObservationMode {
            return true
        }
        return wallet != nil
    }
    
    @discardableResult
    public func createWallet(_ password:String) -> Bool {
        if let w = Wallet(passphrase: password) {
            wallet = w
            fetchBalance()
            return true
        }
        return false
    }
    
    public func fetchBalance() {
        var addr = ""
        if isObservationMode {
            guard let pkh = User.pkh.value else {
                print("pkh is missing")
                return
            }
            addr = pkh
        }
        guard let ad = wallet?.address else {
            return
        }
        addr = ad
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
