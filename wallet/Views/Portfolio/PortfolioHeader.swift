//
//  PortfolioHeader.swift
//  wallet
//
//  Created by Jacky on 2020/10/08.
//

import SwiftUI

struct PortfolioHeader: View {
    @ObservedObject var fetcher = TezosService.shared
    @State var showingReceive = false
    @State var showingSend = false
    var body: some View {
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
                Button(action: {
                    showingReceive.toggle()
                }, label: {
                    Text("Receive")
                        .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center)
                            .foregroundColor(Color.white)
                            .background(Color.accentColor)
                            .cornerRadius(7)
                })
                .sheet(isPresented: $showingReceive) {
                    Receive()
                }
                Button(action: {
                    showingSend.toggle()
                }, label: {
                    Text("Send")
                        .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center)
                            .foregroundColor(Color.accentColor)
                            .cornerRadius(7)
                        .overlay(
                            RoundedRectangle(cornerRadius: 7).stroke().foregroundColor(.accentColor)
                        )
                })
                .sheet(isPresented: $showingSend) {
                    Send()
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: .transactionSent), perform: { _ in
                showingSend = false
                TezosService.shared.fetchBalance()
            })
        }
    }
}

struct PortfolioHeader_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioHeader()
            .preferredColorScheme(.light)
    }
}
