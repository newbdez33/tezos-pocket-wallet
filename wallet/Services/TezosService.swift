//
//  TezosService.swift
//  wallet
//
//  Created by Jacky on 2020/10/08.
//

import Foundation
import TezosKit
import KeychainSwift

public class TezosService: ObservableObject {
    static let shared = TezosService()
    
    @Published var balance:String = "0"
    @Published var isObservationMode = false
    @Published var isWalletLoaded = false
    
    public var wallet:Wallet?
    private let tezos:TezosNodeClient?
    private let keychain = KeychainSwift()

    private init() {
        tezos = TezosNodeClient(remoteNodeURL: Constants.defaultNodeURL, callbackQueue: DispatchQueue(label: "tezosqueue"))
        isObservationMode = User.pkh.value != nil
        isWalletLoaded = loadLocalWallet()
        fetchBalance()
    }
    
    public static func currentDefaultFeesForTransaction() -> [String] {
        let opf = DefaultFeeProvider.fees(for: .transaction, in: .carthage)
        return [opf.fee.humanReadableRepresentation, "\(opf.gasLimit)", "\(opf.storageLimit)"]
    }
    
    public func send(amount:Double, recipient:String, block: @escaping (_ hash:String?, _ error:String?) -> Void ) {
        guard let w = wallet else {
            block(nil, "Wallet is missing")
            return
        }
        debugPrint("\(amount), recipient:\(recipient)")
        tezos?.send(amount: Tez(amount), to: recipient, from: w.address, signatureProvider: w, operationFeePolicy: .default) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let opHash):
                    block(opHash, nil)
                case .failure(let error):
                    block(nil, "\(error)")
                }
            }
        }
    }
    
    public func removeWalletFromLocal() {
        isWalletLoaded = false
        balance = ""
        isObservationMode = false
        wallet = nil
        keychain.delete(Constants.keyWalletMnemonic)
        keychain.delete(Constants.keyWalletPassphrase)
        keychain.delete(Constants.keyWalletPrivateKey)
    }
    
    public func loadLocalWallet() -> Bool {
        if isObservationMode {
            return true
        }
        if let m = keychain.get(Constants.keyWalletMnemonic), let p = keychain.get(Constants.keyWalletPassphrase) {
            wallet = Wallet(mnemonic: m, passphrase: p)
            print("loaded \(wallet?.address ?? "nil")")
        }
        if wallet != nil {
            return true
        }
        if let k = keychain.get(Constants.keyWalletPrivateKey) {
            wallet = Wallet(secretKey: k)
            print("loaded \(wallet?.address ?? "nil")")
        }
        
        return wallet != nil
    }
    
    @discardableResult
    public func createWallet(_ password:String) -> Bool {
        if password == "" {
            return false
        }
        if let w = Wallet(passphrase: password), let m = w.mnemonic {
            wallet = w
            keychain.set(m, forKey: Constants.keyWalletMnemonic)
            keychain.set(password, forKey: Constants.keyWalletPassphrase)
            fetchBalance()
            return true
        }
        return false
    }
    
    @discardableResult
    public func importWallet(mnemonic:String, _ password:String) -> Bool {
        if mnemonic == "" {
            return false
        }
        if let w = Wallet(mnemonic: mnemonic.trimmingCharacters(in: .whitespacesAndNewlines),
                          passphrase: password.trimmingCharacters(in: .whitespacesAndNewlines)),
           let m = w.mnemonic {
            wallet = w
            print("imported \(w.address)")
            keychain.set(m, forKey: Constants.keyWalletMnemonic)
            keychain.set(password, forKey: Constants.keyWalletPassphrase)
            fetchBalance()
            return true
        }
        return false
    }
    
    @discardableResult
    public func importWallet(privateKey:String) -> Bool {
        if privateKey == "" {
            return false
        }
        if let w = Wallet(secretKey: privateKey) {
            wallet = w
            print("imported \(w.address)")
            keychain.set(privateKey, forKey: Constants.keyWalletPrivateKey)
            fetchBalance()
            return true
        }
        return false
    }
    
    public func fetchBalance() {
        guard let w = self.wallet else {
            return
        }
        tezos?.getBalance(wallet: w, completion: { (result) in
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
}
