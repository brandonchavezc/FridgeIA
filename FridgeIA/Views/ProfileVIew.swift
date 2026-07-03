//
//  ProfileVIew.swift
//  FridgeIA
//
//  Created by BRANDON CHAVEZ on 2/07/26.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.fridgeBackground.ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 90))
                        .foregroundColor(.fridgeGreen)
                    
                    Text("Brandon Luis Chavez Choque")
                        .font(.title2.bold())
                    
                    Text("Desarrollador de Fridge IA")
                        .foregroundColor(.fridgeGray)
                    
                    VStack(spacing: 14) {
                        profileRow(title: "Proyecto", value: "Fridge IA")
                        profileRow(title: "Tecnología", value: "SwiftUI + IA")
                        profileRow(title: "Objetivo", value: "Reducir desperdicio")
                    }
                    .padding()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: AppRadius.large))
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .padding(.top, 60)
            }
            .navigationTitle("Perfil")
        }
    }
    
    private func profileRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .foregroundColor(.fridgeGray)
            Spacer()
            Text(value)
                .fontWeight(.semibold)
        }
    }
}
