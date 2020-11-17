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
        
            if fetcher.isWalletLoaded {
                NavigationView {
                    VStack(alignment:.leading) {
                        PortfolioHeader()
                            .padding(.bottom, 10)
                        Operations()
                        Spacer()
                    }
                    .padding()
                    .navigationTitle(Text("Assets"))
                }
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
