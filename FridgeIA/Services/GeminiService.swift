import Foundation
import UIKit

final class GeminiService {
    
    func analyzeFoodImage(_ image: UIImage) async throws -> RecognitionResult {
        guard let imageData = image.jpegData(compressionQuality: 0.6) else {
            throw NSError(domain: "ImageError", code: 0)
        }
        
        let base64Image = imageData.base64EncodedString()
        
        let prompt = """
        Analiza la imagen y detecta TODOS los alimentos visibles.
        Luego genera 3 recetas compatibles usando esos alimentos.

        Responde SOLO en JSON válido. No uses markdown.

        Formato exacto:
        {
          "detectedFoods": [
            {
              "name": "Tomate",
              "category": "Verduras",
              "quantity": "cantidad aproximada",
              "confidence": 0.95,
              "estimatedExpirationDays": 5,
              "icon": "🍅"
            }
          ],
          "recipes": [
            {
              "title": "Ensalada fresca",
              "description": "Receta basada en los alimentos detectados.",
              "ingredients": ["Tomate", "Lechuga"],
              "steps": ["Lavar", "Cortar", "Mezclar"],
              "time": "10 min",
              "difficulty": "Fácil",
              "icon": "🥗"
            }
          ]
        }
        """
        
        let body: [String: Any] = [
            "contents": [
                [
                    "parts": [
                        ["text": prompt],
                        [
                            "inline_data": [
                                "mime_type": "image/jpeg",
                                "data": base64Image
                            ]
                        ]
                    ]
                ]
            ],
            "generationConfig": [
                "temperature": 0.2,
                "response_mime_type": "application/json"
            ]
        ]
        
        let url = URL(string: "https://generativelanguage.googleapis.com/v1beta/models/gemini-flash-latest:generateContent")!
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = [
            URLQueryItem(name: "key", value: AppSecrets.geminiAPIKey)
        ]
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let http = response as? HTTPURLResponse, http.statusCode != 200 {
            let errorText = String(data: data, encoding: .utf8) ?? "Error desconocido"
            print("ERROR GEMINI:", errorText)
            throw NSError(domain: errorText, code: http.statusCode)
        }
        
        let geminiResponse = try JSONDecoder().decode(GeminiResponse.self, from: data)
        
        guard let text = geminiResponse.candidates.first?.content.parts.first?.text else {
            print("RESPUESTA SIN TEXTO:", String(data: data, encoding: .utf8) ?? "")
            throw NSError(domain: "Respuesta vacía de Gemini", code: 1)
        }
        
        let cleanText = text
            .replacingOccurrences(of: "```json", with: "")
            .replacingOccurrences(of: "```", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        print("JSON GEMINI:", cleanText)
        
        return try JSONDecoder().decode(RecognitionResult.self, from: Data(cleanText.utf8))
    }
}

struct GeminiResponse: Codable {
    let candidates: [GeminiCandidate]
}

struct GeminiCandidate: Codable {
    let content: GeminiContent
}

struct GeminiContent: Codable {
    let parts: [GeminiPart]
}

struct GeminiPart: Codable {
    let text: String?
}
