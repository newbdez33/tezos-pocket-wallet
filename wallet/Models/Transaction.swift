//
//  Transaction.swift
//  wallet
//
//  Created by Jacky on 2020/11/16.
//

import SwiftUI

struct Address: Decodable {
    var address: String
}

struct Transaction: Decodable, Identifiable {
    var id: Int64
    var type: String
    var timestamp: String?
    var hash: String?
    var sender: Address?
    var target: Address?
    var amount: Int32?
    var status: String?
}
