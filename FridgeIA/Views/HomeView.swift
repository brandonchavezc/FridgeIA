//
//  HomeView.swift
//  FridgeIA
//
//  Created by BRANDON CHAVEZ on 2/07/26.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appVM: AppViewModel
    @State private var showScanner = false
    
    private var expiringSoonCount: Int {
        appVM.foods.filter { $0.daysRemaining <= 3 }.count
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                Color.fridgeBackground.ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 22) {
                        
                        HomeHeaderView(
                            totalFoods: appVM.foods.count,
                            expiringSoon: expiringSoonCount
                        )
                        .padding(.top, 10)
                        
                        if expiringSoonCount > 0 {
                            ExpirationAlertView(count: expiringSoonCount)
                        }
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Mi inventario")
                                    .font(.title2.bold())
                                    .foregroundColor(.fridgeText)
                                
                                Text("Alimentos registrados en tu refrigerador")
                                    .font(.subheadline)
                                    .foregroundColor(.fridgeGray)
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        VStack(spacing: 14) {
                            ForEach(appVM.foods) { food in
                                FoodCardView(food: food)
                            }
                        }
                        .padding(.horizontal)
                        
                        NavigationLink {
                            CameraScanView()
                                .environmentObject(appVM)
                        } label: {
                            Label("Escanear alimentos con IA", systemImage: "sparkles")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.fridgeGreen)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .shadow(color: .fridgeGreen.opacity(0.25), radius: 10, x: 0, y: 6)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 90)
                    }
                    .padding(.vertical)
                }
                
                FloatingScanButton {
                    showScanner = true
                }
                .padding(.trailing, 24)
                .padding(.bottom, 90)
            }
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showScanner) {
                CameraScanView()
                    .environmentObject(appVM)
            }
        }
    }
}
