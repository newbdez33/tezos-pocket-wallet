//
//  NoWalletView.swift
//  wallet
//
//  Created by Jacky on 2020/10/08.
//

import SwiftUI

struct NoWalletView: View {
    @State var showingImportWallet = false
    @State var showingCreateWallet = false
    
    var body: some View {
        VStack(alignment:.leading, spacing:10) {
            HStack {
                VStack(alignment:.leading) {
                    Text("Tezos pocket wallet")
                        .font(.title)
                    Text("The lightest tezos wallet in the world")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding(.bottom, 10)
            VStack(alignment:.leading) {
                Button("Import wallet") {
                    self.showingImportWallet.toggle()
                }
                .sheet(isPresented: $showingImportWallet) {
                    ImportWallet()
                }
                .font(.appButton)
                Text("If you have a wallet.")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                Divider()
                Button("Create wallet") {
                    self.showingCreateWallet.toggle()
                }
                .sheet(isPresented: $showingCreateWallet) {
                    CreateWallet()
                }
                .font(.appButton)
                Text("If you don't have a wallet or wish to make a new one.")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .onReceive(NotificationCenter.default.publisher(for: .importedWallet), perform: { _ in
            if TezosService.shared.isObservationMode {
                
            }
            showingImportWallet = false
            showingCreateWallet = false
            TezosService.shared.fetchBalance()
        })
    }
}

struct NoWalletView_Previews: PreviewProvider {
    static var previews: some View {
        NoWalletView()
    }
}
