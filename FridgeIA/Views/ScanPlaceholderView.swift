//
//  ScanPlaceholderView.swift
//  FridgeIA
//
//  Created by BRANDON CHAVEZ on 2/07/26.
//

import SwiftUI

struct ScanPlaceholderView: View {
    var body: some View {
        ZStack {
            Color.fridgeBackground.ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image(systemName: "camera.viewfinder")
                    .font(.system(size: 90))
                    .foregroundColor(.fridgeGreen)
                
                Text("Escáner IA")
                    .font(.largeTitle.bold())
                
                Text("En la siguiente parte integraremos la cámara real del iPhone y el reconocimiento de alimentos con IA.")
                    .font(.body)
                    .foregroundColor(.fridgeGray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top, 80)
        }
        .navigationTitle("Escanear")
        .navigationBarTitleDisplayMode(.inline)
    }
}
