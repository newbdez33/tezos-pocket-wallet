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
    @Published var balance:String = "####"
    
    public var wallet:Wallet?
    private let tezos:TezosClient?

    private init() {
        tezos = TezosClient(remoteNodeURL: Constants.defaultNodeURL)
        
        fetchBalance()
    }
    
    public func hasLocalWallet() -> Bool {
        return wallet != nil
    }
    
    private func fetchBalance() {
        tezos?.balance(of: "tz1dwzRWV7Abb1DsgKeYNXmzhVhx2QzfPN9z", completion: { result in
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
