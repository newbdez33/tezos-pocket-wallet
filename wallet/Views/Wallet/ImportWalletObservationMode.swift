//
//  ImportWalletObservationMode.swift
//  wallet
//
//  Created by Jacky on 2020/10/09.
//

import SwiftUI

struct ImportWalletObservationMode: View {
    @State private var key:String = "tz1dwzRWV7Abb1DsgKeYNXmzhVhx2QzfPN9z"
    var body: some View {
        NavigationView {
            VStack(alignment:.leading) {
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $key)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .disableAutocorrection(true)
                        .onChange(of: key, perform: { value in
                            print(key)
                        })
                        .overlay(
                            RoundedRectangle(cornerRadius: 4).stroke()
                        )
                        .frame(height:48)
                    if key.isEmpty {
                        Text("Enter the wallet or contract address.")
                            .font(.caption)
                            .foregroundColor(Color(UIColor.systemGray3))
                            .padding(.leading, 4)
                            .padding(.top, 8)
                    }
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
        }
    }
}

struct ImportWalletObservationMode_Previews: PreviewProvider {
    static var previews: some View {
        ImportWalletObservationMode()
    }
}
