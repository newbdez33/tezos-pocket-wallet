//
//  Font+wallet.swift
//  wallet
//
//  Created by Jacky on 2020/10/09.
//

import SwiftUI

extension Font {
    static var appButton:Font {
        get {
            return .system(size: 18)
        }
    }
    
    static var appPK: Font {
        get {
            return .system(size: 14, design: .monospaced)
        }
    }
}
