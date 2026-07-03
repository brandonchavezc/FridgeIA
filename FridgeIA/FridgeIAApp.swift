//
//  FridgeIAApp.swift
//  FridgeIA
//
//  Created by BRANDON CHAVEZ on 2/07/26.
//

import SwiftUI

@main
struct FridgeIAApp: App {
    @StateObject private var appVM = AppViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appVM)
        }
    }
}
