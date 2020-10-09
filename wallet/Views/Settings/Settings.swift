//
//  Settings.swift
//  wallet
//
//  Created by Jacky on 2020/10/08.
//

import SwiftUI

struct Settings: View {
    @ObservedObject var fetcher = TezosService.shared
    //TODO api endpoint will be automaticly managed by firebase remote config
    
    var body: some View {
        NavigationView {
            if fetcher.isWalletLoaded {
                VStack {
                    HStack {
                        Spacer(minLength: 10)
                        Button(action: {
                            User.pkh.value = nil
                            TezosService.shared.isObservationMode = false
                            TezosService.shared.isWalletLoaded = false
                            TezosService.shared.removeWalletFromLocal()
                            NotificationCenter.default.post(name: .removedWallet, object: nil)
                        }, label: {
                            Text("REMOVE WALLET")
                                .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center)
                                    .foregroundColor(Color.white)
                                    .background(Color.red)
                                    .cornerRadius(7)
                        })
                        Spacer(minLength: 10)
                    }
                    if fetcher.isObservationMode {
                        Text("You wallet is in Observation mode.")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                            .padding(.top, 2)
                    }
                }
                .navigationTitle("Settings")
            }else {
                Text("No wallet imported/created yet.")
                    .navigationTitle("Settings")
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
