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
    
    public func fetchBalance() {
        guard let pkh = User.pkh.value else {
            print("pkh is missing")
            return
        }
        tezos?.balance(of: pkh, completion: { result in
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
