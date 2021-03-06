//
//  ImportWalletObservationMode.swift
//  wallet
//
//  Created by Jacky on 2020/10/09.
//

import SwiftUI

struct ImportObservationMode: View {
    @State private var key:String = ""
    var body: some View {
        NavigationView {
            VStack(alignment:.leading) {
                Text("Observation Mode")
                    .font(.largeTitle)
                    .bold()
                ZStack(alignment: .topLeading) {
                    if key.isEmpty {
                        Text("Enter the wallet or contract address.")
                            .font(.appPK)
                            .foregroundColor(.primary)
                            .padding(.leading, 4)
                            .padding(.top, 8)
                            .disabled(true)
                    }
                    TextEditor(text: $key)
                        .font(.appPK)
                        .foregroundColor(.primary)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .overlay(
                            RoundedRectangle(cornerRadius: 7).stroke().foregroundColor(.secondary)
                        )
                        .frame(height:48)
                        .opacity(0.8)
                    
                }
                Text("Observation Mode does not require importing a private key.")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 10)
                Button(action: {
                    if WalletUtil.isValidAddress(key) {
                        User.pkh.value = key
                        TezosService.shared.isObservationMode = true
                        TezosService.shared.isWalletLoaded = true
                        TezosService.shared.fetchBalance()
                        NotificationCenter.default.post(name: .importedWallet, object: nil)
                    }else {
                        print("key is not valid: \(key)")
                    }
                    
                }, label: {
                    Text("Import")
                        .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center)
                            .foregroundColor(Color.white)
                            .background(Color.accentColor)
                            .cornerRadius(7)
                })
                Spacer()
            }
            .padding()
            .navigationTitle("Observation Mode")
            .navigationBarHidden(true)
        }
    }
}

struct ImportWalletObservationMode_Previews: PreviewProvider {
    static var previews: some View {
        ImportObservationMode()
    }
}
