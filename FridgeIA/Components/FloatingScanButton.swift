//
//  FloatingScanButton.swift
//  FridgeIA
//
//  Created by BRANDON CHAVEZ on 2/07/26.
//

import SwiftUI

struct FloatingScanButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "camera.fill")
                .font(.title2.bold())
                .foregroundColor(.white)
                .frame(width: 64, height: 64)
                .background(Color.fridgeGreen)
                .clipShape(Circle())
                .shadow(color: .fridgeGreen.opacity(0.45), radius: 12, x: 0, y: 8)
        }
    }
}
