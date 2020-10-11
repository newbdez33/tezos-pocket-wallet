//
//  Receive.swift
//  wallet
//
//  Created by Jacky on 2020/10/10.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct Receive: View {
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    @State private var showingSheet = false
    
    var body: some View {
        VStack {
            Image(uiImage: generateQRCode(from: TezosService.shared.wallet?.address ?? ""))
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .padding()
            Text("Address of Your Tezos wallet")
                .font(.footnote)
                .foregroundColor(.secondary)
            Text(TezosService.shared.wallet?.address ?? "Failed")
                .font(.appPK)
                .padding(6)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [3])).foregroundColor(.secondary)
                )
            HStack(spacing:24) {
                Button(action: {
                    UIPasteboard.general.string = TezosService.shared.wallet?.address ?? ""
                }, label: {
                    HStack {
                        Image(systemName: "doc.on.doc")
                        Text("Copy address")
                            .font(.appButton)
                    }
                })
                Button(action: {
                    showingSheet = true
                }, label: {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("Share address")
                            .font(.appButton)
                    }
                })
                .sheet(isPresented: $showingSheet, onDismiss: {
                    print("Dismiss")
                }, content: {
                    AppActivityView(activityItems: [
                                        TezosService.shared.wallet?.address ?? "",
                                        TezosService.shared.wallet?.address ?? "",
                                        generateQRCode(from: TezosService.shared.wallet?.address ?? "") ])
                })
            }
            .padding(.top, 8)
            
        }
    }
    
    func generateQRCode(from string: String) -> UIImage {
        if string == "" {
            return UIImage(systemName: "xmark.circle") ?? UIImage()
        }
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct Receive_Previews: PreviewProvider {
    static var previews: some View {
        Receive()
    }
}
