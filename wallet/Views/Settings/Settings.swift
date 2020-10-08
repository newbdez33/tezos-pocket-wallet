//
//  Settings.swift
//  wallet
//
//  Created by Jacky on 2020/10/08.
//

import SwiftUI

struct Settings: View {

    //TODO api endpoint will be automaticly managed by firebase remote config
    
    var body: some View {
        NavigationView {
            VStack {
                Text("No settings for now")
            }
            .navigationTitle("Settings")
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
