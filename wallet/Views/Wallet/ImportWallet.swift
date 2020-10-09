//
//  ImportWallet.swift
//  wallet
//
//  Created by Jacky on 2020/10/08.
//

import SwiftUI

struct ImportWallet: View {
    var body: some View {
        NavigationView {
            VStack(alignment:.leading) {
                HStack {
                    NavigationLink(destination: ImportPrivateKey()) {
                        Image(systemName: "wallet.pass")
                        VStack(alignment:.leading) {
                            Text("Private key")
                                .font(.appButton)
                            Text("Import the wallet with the private key")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                            .padding(.leading, 4)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.primary)
                }
                Divider()
                HStack {
                    NavigationLink(destination: ImportMnemonic()) {
                        Image(systemName: "a.book.closed")
                        VStack(alignment:.leading) {
                            Text("Mnemonic")
                                .font(.appButton)
                            Text("Import the wallet with the private key")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                            .padding(.leading, 4)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.primary)
                }
                Divider()
                HStack {
                    NavigationLink(destination: ImportObservationMode()) {
                        Image(systemName: "eye.circle")
                        VStack(alignment:.leading) {
                            Text("Observation mode")
                                .font(.appButton)
                            Text("Import the wallet with the private key")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                            .padding(.leading, 2)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.primary)
                }
            }
            .padding()
            .navigationTitle("Import wallet")
        }
    }
}

struct ImportWallet_Previews: PreviewProvider {
    static var previews: some View {
        ImportWallet()
    }
}
