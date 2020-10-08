//
//  ContentView.swift
//  wallet
//
//  Created by Jacky on 2020/10/07.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Portfolio().tabItem {
                Image(systemName: "note")
                Text("Assets")
            }
            Settings().tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
