//
//  HomeHeaderView.swift
//  FridgeIA
//
//  Created by BRANDON CHAVEZ on 2/07/26.
//

import SwiftUI

struct HomeHeaderView: View {
    let totalFoods: Int
    let expiringSoon: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Fridge IA")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("Tu refrigerador inteligente")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.85))
                }
                
                Spacer()
                
                ZStack {
                    Circle()
                        .fill(.white.opacity(0.20))
                        .frame(width: 56, height: 56)
                    
                    Image(systemName: "leaf.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                }
            }
            
            HStack(spacing: 14) {
                summaryItem(
                    icon: "refrigerator.fill",
                    title: "Productos",
                    value: "\(totalFoods)"
                )
                
                summaryItem(
                    icon: "exclamationmark.triangle.fill",
                    title: "Por vencer",
                    value: "\(expiringSoon)"
                )
            }
        }
        .padding(22)
        .background(
            LinearGradient(
                colors: [.fridgeGreen, .fridgeDarkGreen],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .shadow(color: .fridgeGreen.opacity(0.30), radius: 18, x: 0, y: 10)
        .padding(.horizontal)
    }
    
    private func summaryItem(icon: String, title: String, value: String) -> some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .foregroundColor(.white)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(value)
                    .font(.headline.bold())
                    .foregroundColor(.white)
                
                Text(title)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.80))
            }
            
            Spacer()
        }
        .padding()
        .background(.white.opacity(0.16))
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}
