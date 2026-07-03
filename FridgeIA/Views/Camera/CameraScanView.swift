import SwiftUI
import UIKit

struct CameraScanView: View {
    @EnvironmentObject var appVM: AppViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedImage: UIImage?
    @State private var showCamera = false
    @State private var showPhotoLibrary = false
    @State private var isAnalyzing = false
    @State private var errorMessage = ""
    @State private var showResult = false
    
    private let geminiService = GeminiService()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.fridgeBackground.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        header
                        imagePreview
                        actionButtons
                        
                        if isAnalyzing {
                            ProgressView("Analizando alimentos con IA...")
                                .font(.headline)
                                .tint(.fridgeGreen)
                                .padding()
                        }
                        
                        if !errorMessage.isEmpty {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .font(.caption)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        
                        if showResult {
                            resultSection
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Escáner IA")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showCamera) {
                ImagePicker(selectedImage: $selectedImage, sourceType: .camera)
            }
            .sheet(isPresented: $showPhotoLibrary) {
                ImagePicker(selectedImage: $selectedImage, sourceType: .photoLibrary)
            }
        }
    }
    
    private var header: some View {
        VStack(spacing: 10) {
            Image(systemName: "camera.viewfinder")
                .font(.system(size: 70))
                .foregroundColor(.fridgeGreen)
            
            Text("Escanea tus alimentos")
                .font(.largeTitle.bold())
                .foregroundColor(.fridgeText)
            
            Text("Toma una foto clara y la IA detectará los alimentos visibles.")
                .foregroundColor(.fridgeGray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding(.top, 20)
    }
    
    private var imagePreview: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 28)
                .fill(Color.fridgeLightGreen)
                .frame(height: 320)
            
            if let selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 320)
                    .clipShape(RoundedRectangle(cornerRadius: 28))
            } else {
                VStack(spacing: 14) {
                    Image(systemName: "photo.on.rectangle.angled")
                        .font(.system(size: 60))
                        .foregroundColor(.fridgeGreen)
                    
                    Text("Vista previa de la imagen")
                        .font(.headline)
                        .foregroundColor(.fridgeGreen)
                }
            }
        }
        .padding(.horizontal)
    }
    
    private var actionButtons: some View {
        VStack(spacing: 14) {
            Button {
                showCamera = true
            } label: {
                Label("Tomar foto", systemImage: "camera.fill")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.fridgeGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
            }
            
            Button {
                showPhotoLibrary = true
            } label: {
                Label("Elegir desde galería", systemImage: "photo.fill")
                    .font(.headline)
                    .foregroundColor(.fridgeGreen)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.fridgeLightGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
            }
            
            Button {
                Task {
                    await analyzeImage()
                }
            } label: {
                Label("Analizar con IA", systemImage: "sparkles")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(selectedImage == nil ? Color.gray : Color.fridgeGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
            }
            .disabled(selectedImage == nil || isAnalyzing)
        }
        .padding(.horizontal)
    }
    
    private var resultSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Alimentos detectados")
                .font(.title2.bold())
            
            ForEach(appVM.detectedFoods) { food in
                HStack {
                    Text(food.icon)
                        .font(.largeTitle)
                    
                    VStack(alignment: .leading) {
                        Text(food.name)
                            .font(.headline)
                        
                        Text(food.category)
                            .foregroundColor(.fridgeGray)
                    }
                    
                    Spacer()
                    
                    Text("\(Int(food.confidence * 100))%")
                        .font(.caption.bold())
                        .foregroundColor(.fridgeGreen)
                }
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 18))
            }
            
            Button {
                appVM.addDetectedFoodsToInventory()
                dismiss()
            } label: {
                Text("Guardar alimentos en inventario")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.fridgeGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
            }
            
            Text("Recetas recomendadas")
                .font(.title2.bold())
                .padding(.top)
            
            ForEach(appVM.generatedRecipes) { recipe in
                VStack(alignment: .leading, spacing: 8) {
                    Text("\(recipe.icon) \(recipe.title)")
                        .font(.headline)
                    
                    Text(recipe.description)
                        .foregroundColor(.fridgeGray)
                    
                    Text("Tiempo: \(recipe.time) · \(recipe.difficulty)")
                        .font(.caption.bold())
                        .foregroundColor(.fridgeGreen)
                }
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 18))
            }
        }
        .padding()
    }
    
    private func analyzeImage() async {
        guard let selectedImage else { return }
        
        isAnalyzing = true
        errorMessage = ""
        showResult = false
        
        do {
            let result = try await geminiService.analyzeFoodImage(selectedImage)
            
            await MainActor.run {
                appVM.saveAIResult(result)
                showResult = true
            }
        } catch {
            await MainActor.run {
                errorMessage = "Error IA: \(error.localizedDescription)"
                print("ERROR REAL:", error)
            }
        }
        
        await MainActor.run {
            isAnalyzing = false
        }
    }
}
