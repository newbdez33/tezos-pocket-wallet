//
//  Operations.swift
//  wallet
//
//  Created by Jacky on 2020/11/16.
//

import SwiftUI

struct Operations: View {
    @ObservedObject var fetcher = TezosService.shared
    var body: some View {
        VStack {
            LazyVStack(alignment: .leading, spacing: 2) {
                ForEach(fetcher.operations) { o in
                    OperationView(transaction: o)
                }
            }
        }
    }
}

struct OperationView: View {
    var transaction: Transaction
    var body: some View {
        HStack {
            if transaction.type == "transaction" {
                if let w = TezosService.shared.wallet?.address, let t = transaction.target?.address, let r = transaction.sender?.address {
                    if w == r {
                        Image(systemName: "rectangle.badge.minus")
                        .font(.title2)
                    }
                    if w == t {
                        Image(systemName: "rectangle.badge.plus")
                        .font(.title2)
                    }
                }
                
            }else {
                Image(systemName: "rectangle.dashed")
                .font(.title2)
            }
            
        }
    }
}

struct Operations_Previews: PreviewProvider {
    static var previews: some View {
        OperationView(transaction: Transaction(id: 1, type: "transaction", timestamp: "2020-11-16T06:46:01Z", hash: "ooDsaswrJYm5LQx4JGRfk6KMchoHTQmQZSq2QT7rjpcABoX6hq8", sender: Address(address: "tz1dwzRWV7Abb1DsgKeYNXmzhVhx2QzfPN9z"), target: Address(address: "tz1dwzRWV7Abb1DsgKeYNXmzhVhx2QzfPN9z"), amount: 1000000, status: "applied"))
    }
}
