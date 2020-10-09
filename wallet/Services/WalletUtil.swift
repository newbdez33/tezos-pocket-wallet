//
//  Utils.swift
//  wallet
//
//  Created by Jacky on 2020/10/09.
//

import Foundation

class WalletUtil {
    static public func isValidAddress(_ addr:String) -> Bool {
        if Data(base64Encoded: addr) == nil {
            return false
        }
        return true
    }
}
