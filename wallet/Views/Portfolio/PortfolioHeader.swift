//
//  PortfolioHeader.swift
//  wallet
//
//  Created by Jacky on 2020/10/08.
//

import SwiftUI

struct PortfolioHeader: View {
    @ObservedObject var fetcher = TezosService.shared
    var body: some View {
        NavigationView {
            VStack(alignment:.leading, spacing:10) {
                HStack {
                    VStack(alignment:.leading) {
                        Text("\(fetcher.balance) XTZ")
                            .font(.title)
                        Text("total balance")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
                HStack {
                    Button(action: {}, label: {
                        Text("Receive")
                            .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center)
                                .foregroundColor(Color.white)
                                .background(Color.accentColor)
                                .cornerRadius(7)
                    })
                    Button(action: {}, label: {
                        Text("Send")
                            .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center)
                                .foregroundColor(Color.accentColor)
                                .cornerRadius(7)
                            .overlay(
                                RoundedRectangle(cornerRadius: 7).stroke().foregroundColor(.accentColor)
                            )
                    })
                }
            }
            .padding()
            .navigationTitle(Text("Assets"))
        }
    }
}

struct PortfolioHeader_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioHeader()
            .preferredColorScheme(.light)
    }
}
