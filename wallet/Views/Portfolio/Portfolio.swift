//
//  Portfolio.swift
//  wallet
//
//  Created by Jacky on 2020/10/08.
//

import SwiftUI

struct Portfolio: View {
    @ObservedObject var fetcher = TezosService.shared
    var body: some View {
        Group {
            if fetcher.isWalletLoaded {
                PortfolioHeader()
            }else {
                NoWalletView()
            }
        }
    }
}

struct Portfolio_Previews: PreviewProvider {
    static var previews: some View {
        Portfolio()
    }
}
