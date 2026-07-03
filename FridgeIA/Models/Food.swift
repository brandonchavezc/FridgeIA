//
//  Food.swift
//  FridgeIA
//
//  Created by BRANDON CHAVEZ on 2/07/26.
//

import Foundation
import SwiftUI

struct Food: Identifiable, Hashable, Codable {
    let id: UUID
    var name: String
    var category: String
    var quantity: String
    var expirationDate: Date
    var confidence: Double
    var icon: String
    
    init(
        id: UUID = UUID(),
        name: String,
        category: String,
        quantity: String,
        expirationDate: Date,
        confidence: Double = 0.0,
        icon: String = "🥗"
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.quantity = quantity
        self.expirationDate = expirationDate
        self.confidence = confidence
        self.icon = icon
    }
    
    var daysRemaining: Int {
        Calendar.current.dateComponents([.day], from: Date(), to: expirationDate).day ?? 0
    }
    
    var statusText: String {
        if daysRemaining < 0 {
            return "Vencido"
        } else if daysRemaining <= 3 {
            return "Próximo a vencer"
        } else {
            return "Fresco"
        }
    }
    
    var statusColor: Color {
        if daysRemaining < 0 {
            return .red
        } else if daysRemaining <= 3 {
            return .orange
        } else {
            return .green
        }
    }
}
