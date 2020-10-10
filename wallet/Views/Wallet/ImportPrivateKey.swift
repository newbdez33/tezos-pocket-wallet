//
//  ImportPrivateKey.swift
//  wallet
//
//  Created by Jacky on 2020/10/09.
//

import SwiftUI

struct ImportPrivateKey: View {
    @State private var key:String = ""
    @State private var password:String = ""
    @State private var isShowingPassword = false
    @State private var isLoading = false
    var body: some View {
        NavigationView {
            VStack(alignment:.leading) {
                Text("Private Key")
                    .font(.largeTitle)
                    .bold()
                ZStack(alignment: .topLeading) {
                    if key.isEmpty {
                        Text("Enter the private key")
                            .font(.appPK)
                            .foregroundColor(.primary)
                            .padding(.leading, 4)
                            .padding(.top, 8)
                    }
                    
                    TextEditor(text: $key)
                        .font(.appPK)
                        .foregroundColor(.primary)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .overlay(
                            RoundedRectangle(cornerRadius: 7).stroke().foregroundColor(.secondary)
                        )
                        .frame(height:68)
                        .disabled(isLoading)
                        .opacity(0.8)
                    
                }
                Text("Keep your private key safe!")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 10)
                    .frame(minHeight:44)
                Button(action: {
                    if isLoading {
                        return
                    }
                    isLoading = true
                    DispatchQueue.global(qos: .userInitiated).async {
                        let ret = TezosService.shared.importWallet(privateKey: key)
                        DispatchQueue.main.async {
                            isLoading = false
                            if ret  {
                                TezosService.shared.isObservationMode = false
                                TezosService.shared.isWalletLoaded = true
                                NotificationCenter.default.post(name: .importedWallet, object: nil)
                            }else {
                                print("Create new wallet failed.")
                            }
                        }
                    }
                }, label: {
                    if isLoading {
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                    }else {
                        Text("Import")
                            .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center)
                                .foregroundColor(Color.white)
                                .background(Color.accentColor)
                                .cornerRadius(7)
                    }
                    
                })
                Spacer()
            }
            .padding()
            .navigationTitle("Mnemonic")
            .navigationBarHidden(true)
        }
    }
}

struct ImportPrivateKey_Previews: PreviewProvider {
    static var previews: some View {
        ImportPrivateKey()
    }
}
