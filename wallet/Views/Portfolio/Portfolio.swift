//
//  Portfolio.swift
//  wallet
//
//  Created by Jacky on 2020/10/08.
//

import SwiftUI

struct Portfolio: View {
    
    var body: some View {
        if TezosService.shared.hasLocalWallet() {
            PortfolioHeader()
        }else {
            NoWalletView()
        }
    }
}

struct Portfolio_Previews: PreviewProvider {
    static var previews: some View {
        Portfolio()
    }
}
