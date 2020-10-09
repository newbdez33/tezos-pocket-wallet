//
//  ImportWalletObservationMode.swift
//  wallet
//
//  Created by Jacky on 2020/10/09.
//

import SwiftUI

struct ImportWalletObservationMode: View {
    @State private var key:String = ""
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
                        Text("Enter the address of your wallet.")
                            .font(.caption)
                            .foregroundColor(Color(UIColor.systemGray3))
                            .padding(.leading, 4)
                            .padding(.top, 2)
                    }
                }
                Text("Observation Mode does not require importing a private key.")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                Button(action: {}, label: {
                    Text("Import")
                })
                Spacer()
            }.padding()
            .navigationTitle("Observation Mode")
        }
    }
}

struct ImportWalletObservationMode_Previews: PreviewProvider {
    static var previews: some View {
        ImportWalletObservationMode()
    }
}
