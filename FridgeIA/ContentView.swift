//
//  ContentView.swift
//  FridgeIA
//
//  Created by BRANDON CHAVEZ on 2/07/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Inicio")
                }
            
            RecipesView()
                .tabItem {
                    Image(systemName: "fork.knife")
                    Text("Recetas")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle.fill")
                    Text("Perfil")
                }
        }
        .tint(.fridgeGreen)
    }
}

#Preview {
    ContentView()
        .environmentObject(AppViewModel())
}
