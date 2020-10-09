//
//  ContentView.swift
//  wallet
//
//  Created by Jacky on 2020/10/07.
//

import SwiftUI

struct ContentView: View {
    @State private var tabIndex = 0
    var body: some View {
        TabView(selection:$tabIndex) {
            Portfolio().tabItem {
                Image(systemName: "note")
                Text("Assets")
            }.tag(0)
            Settings().tabItem {
                Image(systemName: "gearshape")
                Text("Settings")
            }.tag(1)
        }
        .onReceive(NotificationCenter.default.publisher(for: .removedWallet), perform: { _ in
            tabIndex = 0
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
