//
//  Notification+wallet.swift
//  wallet
//
//  Created by Jacky on 2020/10/09.
//

import Foundation

extension Notification.Name {
    static let transactionSent = Notification.Name("transactionSent")
    static let importedWallet = Notification.Name("importedWallet")
    static let removedWallet = Notification.Name("removedWallet")
}

@objc extension NSNotification {
    public static let importedWallet = Notification.Name.importedWallet
    public static let removedWallet = Notification.Name.removedWallet
    public static let transactionSent = Notification.Name.transactionSent
}
