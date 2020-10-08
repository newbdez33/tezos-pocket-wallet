//
//  User.swift
//  wallet
//
//  Created by Jacky on 2020/10/08.
//

import Foundation
import OneStore

enum User {
    static let pkh = OneStore<String>(stack: User.stack, key: "pkh")
    static let endpoint = OneStore<String>(stack: User.stack, key: "endpoint")
    
    private static let stack = Stack(userDefaults: UserDefaults.standard, domain: "me")
}
