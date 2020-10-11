//
//  Utils.swift
//  wallet
//
//  Created by Jacky on 2020/10/09.
//

import SwiftUI

class WalletUtil {
    static public func isValidAddress(_ addr:String) -> Bool {
        if Data(base64Encoded: addr) == nil {
            return false
        }
        return true
    }
    
    static public func myQRcode() -> UIImage {
        guard let string = TezosService.shared.wallet?.address else {
            return UIImage()
        }
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return UIImage()
    }
}
