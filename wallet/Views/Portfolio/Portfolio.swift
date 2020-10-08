//
//  Portfolio.swift
//  wallet
//
//  Created by Jacky on 2020/10/08.
//

import SwiftUI

struct Portfolio: View {
    @ObservedObject var fetcher = TezosService.shared
    var body: some View {
        NavigationView {
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
                    Button("Receive") {
                        //
                    }
                    Button("Send") {
                        //
                    }
                }
            }
            .padding()
            .navigationTitle(Text("Assets"))
        }
        
    }
}

struct Portfolio_Previews: PreviewProvider {
    static var previews: some View {
        Portfolio()
    }
}
