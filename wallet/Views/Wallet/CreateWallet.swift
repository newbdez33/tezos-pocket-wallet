//
//  CreateWallet.swift
//  wallet
//
//  Created by Jacky on 2020/10/08.
//

import SwiftUI

//TODO it must works with 1password and ios keychain.

struct CreateWallet: View {
    @State private var password:String = ""
    @State private var isShowingPassword = false
    @State private var isLoading = false
    var body: some View {
        NavigationView {
            VStack(alignment:.leading) {
                Text("Password")
                    .font(.appButton)
                ZStack(alignment:.trailing) {
                    if isShowingPassword {
                        TextField("Wallet password here", text: $password)
                            .font(.appButton)
                            .frame(height:30)
                            .disabled(isLoading)
                    } else {
                        SecureField("Wallet password here", text: $password)
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
                Button(action: {
                    if isLoading {
                        return
                    }
                    isLoading = true
                    DispatchQueue.global(qos: .userInitiated).async {
                        let ret = TezosService.shared.createWallet(password)
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
                        Text("Create wallet")
                            .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center)
                            .foregroundColor(Color.white)
                            .background(Color.accentColor)
                            .cornerRadius(7)
                    }

                })
                Spacer()
            }
            .padding()
            .navigationTitle("Create new wallet")
        }
    }
}

struct CreateWallet_Previews: PreviewProvider {
    static var previews: some View {
        CreateWallet()
    }
}
