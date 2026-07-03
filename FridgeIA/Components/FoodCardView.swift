//
//  FoodCardView.swift
//  FridgeIA
//
//  Created by BRANDON CHAVEZ on 2/07/26.
//

import SwiftUI

struct FoodCardView: View {
    let food: Food
    
    var body: some View {
        HStack(spacing: 14) {
            Text(food.icon)
                .font(.system(size: 36))
                .frame(width: 58, height: 58)
                .background(Color.fridgeLightGreen)
                .clipShape(RoundedRectangle(cornerRadius: 18))
            
            VStack(alignment: .leading, spacing: 5) {
                Text(food.name)
                    .font(.headline)
                    .foregroundColor(.fridgeText)
                
                Text(food.quantity)
                    .font(.subheadline)
                    .foregroundColor(.fridgeGray)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(food.statusText)
                    .font(.caption.bold())
                    .foregroundColor(food.statusColor)
                
                Text("\(max(food.daysRemaining, 0)) días")
                    .font(.caption)
                    .foregroundColor(.fridgeGray)
            }
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .shadow(color: .black.opacity(0.07), radius: 10, x: 0, y: 5)
    }
}
