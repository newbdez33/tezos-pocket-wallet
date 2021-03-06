//
//  Send.swift
//  wallet
//
//  Created by Jacky on 2020/10/10.
//

import SwiftUI

struct Send: View {
    @State var recipient:String = "tz1LZdecweejNLrczvEnFZceHGUxXLKhwmPB"
    @State var amount:String = "1"
    @State var fee:String = ""
    @State private var isShowingFeeField = false
    @State private var isLoading = false
    let fees = TezosService.currentDefaultFeesForTransaction()
    
    var body: some View {
        VStack(alignment:.leading) {
            Text("Send")
                .font(.largeTitle)
                .bold()
            Text("Recipient address")
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(.top, 8)
            TextField("recipient address", text: $recipient)
                .disabled(isLoading)
                .font(.appPK)
            Divider()
            Text("Amount")
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(.top, 8)
            ZStack(alignment:.trailing) {
                Text("XTZ")
                    .font(.appPK)
                    .foregroundColor(.secondary)
                TextField("0", text: $amount)
                    .disabled(isLoading)
                    .font(.appPK)
            }
            Divider()
            Text("Default fees: \(fees[0]), gas limit: \(fees[1]), storage limit: \(fees[2])")
                .font(.footnote)
                .foregroundColor(.secondary)
            Button(action: {
                if isLoading {
                    return
                }
                guard let amountDouble = Double(amount) else {
                    return
                }
                if !WalletUtil.isValidAddress(recipient) {
                    return
                }
                isLoading = true
                TezosService.shared.send(amount: amountDouble, recipient: recipient) { (hash, err) in
                    isLoading = false
                    if err != nil {
                        //print(err ?? "")
                    }else {
                        print(hash ?? "hash is nil")
                        NotificationCenter.default.post(name: .transactionSent, object: nil)
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
                    Text("Send")
                        .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center)
                            .foregroundColor(Color.white)
                            .background(Color.accentColor)
                            .cornerRadius(7)
                }
            })
            .padding(.top, 10)

        }
        .padding(.leading, 10)
        .padding(.trailing, 10)
    }
}

struct Send_Previews: PreviewProvider {
    static var previews: some View {
        Send()
    }
}
