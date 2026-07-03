import Foundation
import SwiftUI
import Combine

final class AppViewModel: ObservableObject {
    @Published var foods: [Food] = [
        Food(name: "Leche entera", category: "Lácteos", quantity: "1 litro", expirationDate: Calendar.current.date(byAdding: .day, value: 2, to: Date())!, confidence: 0.95, icon: "🥛"),
        Food(name: "Huevos", category: "Proteínas", quantity: "6 unidades", expirationDate: Calendar.current.date(byAdding: .day, value: 5, to: Date())!, confidence: 0.90, icon: "🥚"),
        Food(name: "Tomate", category: "Verduras", quantity: "3 unidades", expirationDate: Calendar.current.date(byAdding: .day, value: 3, to: Date())!, confidence: 0.88, icon: "🍅")
    ]
    
    @Published var detectedFoods: [DetectedFood] = []
    @Published var generatedRecipes: [Recipe] = []
    
    func addFood(_ food: Food) {
        foods.insert(food, at: 0)
    }
    
    func saveAIResult(_ result: RecognitionResult) {
        detectedFoods = result.detectedFoods
        generatedRecipes = result.recipes
    }
    
    func addDetectedFoodsToInventory() {
        for detected in detectedFoods {
            let date = Calendar.current.date(
                byAdding: .day,
                value: detected.estimatedExpirationDays,
                to: Date()
            ) ?? Date()
            
            let food = Food(
                name: detected.name,
                category: detected.category,
                quantity: detected.quantity,
                expirationDate: date,
                confidence: detected.confidence,
                icon: detected.icon
            )
            
            addFood(food)
        }
    }
}
