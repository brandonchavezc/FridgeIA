//
//  RecognitionResult.swift
//  FridgeIA
//
//  Created by BRANDON CHAVEZ on 2/07/26.
//

import Foundation

struct RecognitionResult: Codable {
    var detectedFoods: [DetectedFood]
    var recipes: [Recipe]
}

struct DetectedFood: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var category: String
    var quantity: String
    var confidence: Double
    var estimatedExpirationDays: Int
    var icon: String
    
    enum CodingKeys: String, CodingKey {
        case name, category, quantity, confidence, estimatedExpirationDays, icon
    }
}
