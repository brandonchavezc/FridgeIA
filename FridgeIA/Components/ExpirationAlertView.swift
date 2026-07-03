//
//  ExpirationAlertView.swift
//  FridgeIA
//
//  Created by BRANDON CHAVEZ on 2/07/26.
//

import SwiftUI

struct ExpirationAlertView: View {
    let count: Int
    
    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: "exclamationmark.circle.fill")
                .font(.title2)
                .foregroundColor(.orange)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("\(count) productos próximos a vencer")
                    .font(.headline)
                    .foregroundColor(.fridgeText)
                
                Text("Revisa tu inventario para evitar desperdicios.")
                    .font(.subheadline)
                    .foregroundColor(.fridgeGray)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.orange.opacity(0.12))
        .overlay(
            RoundedRectangle(cornerRadius: 22)
                .stroke(Color.orange.opacity(0.35), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .padding(.horizontal)
    }
}
