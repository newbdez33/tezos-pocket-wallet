//
//  ImportMnemonic.swift
//  wallet
//
//  Created by Jacky on 2020/10/09.
//

import SwiftUI

struct ImportMnemonic: View {
    @State private var key:String = ""
    @State private var password:String = ""
    @State private var isShowingPassword = false
    @State private var isLoading = false
    var body: some View {
        NavigationView {
            VStack(alignment:.leading) {
                Text("Mnemonic")
                    .font(.largeTitle)
                    .bold()
                ZStack(alignment: .topLeading) {
                    if key.isEmpty {
                        Text("Please use space to separate the mnemonic words.")
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
                Text("Password")
                    .font(.appButton)
                    .padding(.top, 10)
                ZStack(alignment:.trailing) {
                    if isShowingPassword {
                        TextField("Wallet password", text: $password)
                            .font(.appButton)
                            .frame(height:30)
                            .disabled(isLoading)
                    } else {
                        SecureField("Wallet password", text: $password)
                            .font(.appButton)
                            .frame(height:30)
                            .disabled(isLoading)
                    }
                    Button(action: {
                        isShowingPassword.toggle()
                    }, label: {
                        if isShowingPassword {
                            Image(systemName: "eye")
                                .foregroundColor(.secondary)
                        }else {
                            Image(systemName: "eye.slash")
                                .foregroundColor(.secondary)
                        }
                        
                    })
                    
                }
                Divider()
                Text("Password strength is critical to guard your wallet. Please backup cautiously.")
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
                        let ret = TezosService.shared.importWallet(mnemonic: key, password)
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

struct ImportMnemonic_Previews: PreviewProvider {
    static var previews: some View {
        ImportMnemonic()
            .preferredColorScheme(.dark)
    }
}
