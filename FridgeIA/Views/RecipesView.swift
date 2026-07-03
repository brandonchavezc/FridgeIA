//
//  RecipesView.swift
//  FridgeIA
//
//  Created by BRANDON CHAVEZ on 2/07/26.
//

import SwiftUI

struct RecipesView: View {
    @EnvironmentObject var appVM: AppViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.fridgeBackground.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 16) {
                        if appVM.generatedRecipes.isEmpty {
                            VStack(spacing: 16) {
                                Image(systemName: "fork.knife.circle.fill")
                                    .font(.system(size: 80))
                                    .foregroundColor(.fridgeGreen)
                                
                                Text("Recetas IA")
                                    .font(.largeTitle.bold())
                                
                                Text("Aquí aparecerán las recetas recomendadas según los alimentos detectados por la cámara.")
                                    .foregroundColor(.fridgeGray)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal)
                            }
                            .padding(.top, 80)
                        } else {
                            ForEach(appVM.generatedRecipes) { recipe in
                                VStack(alignment: .leading, spacing: 12) {
                                    Text(recipe.icon)
                                        .font(.system(size: 50))
                                    
                                    Text(recipe.title)
                                        .font(.title3.bold())
                                    
                                    Text(recipe.description)
                                        .foregroundColor(.fridgeGray)
                                    
                                    Text("Tiempo: \(recipe.time)")
                                        .font(.subheadline.bold())
                                        .foregroundColor(.fridgeGreen)
                                }
                                .padding()
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: AppRadius.large))
                                .shadow(color: .black.opacity(0.06), radius: 8, y: 4)
                                .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Recetas")
        }
    }
}
