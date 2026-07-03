//
//  Recipe.swift
//  FridgeIA
//
//  Created by BRANDON CHAVEZ on 2/07/26.
//

import Foundation

struct Recipe: Identifiable, Hashable, Codable {
    var id = UUID()
    var title: String
    var description: String
    var ingredients: [String]
    var steps: [String]
    var time: String
    var difficulty: String
    var icon: String
    
    enum CodingKeys: String, CodingKey {
        case title, description, ingredients, steps, time, difficulty, icon
    }
}
