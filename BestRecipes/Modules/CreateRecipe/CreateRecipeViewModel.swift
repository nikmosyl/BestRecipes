//
//  CreateRecipeViewModel.swift
//  BestRecipes
//
//  Created by Иван Семикин on 12/08/2025.
//

import SwiftUI
import PhotosUI

@MainActor
final class CreateRecipeViewModel: ObservableObject {
    
    // MARK: - Constants
    private enum Constants {
        static let defaultTitle = "My Recipe"
        static let defaultReadyInMinutes = 20
        static let defaultServings = 1
        static let defaultInstruction = ""
        static let authorName = "Mine"
        
        // ID ranges для разных источников
        enum IDRange {
            static let userCreatedMin = 10_001
            static let userCreatedMax = 99_999
        }
    }
    
    @Published var savedRecipesData = DataManager.shared.getRecipesFrom(.mine)
    
    @Published var title: String = ""
    
    @Published var showCookTimePicker: Bool = false
    @Published var readyInMinutes: Int = Constants.defaultReadyInMinutes
    
    @Published var showServesPicker: Bool = false
    @Published var servings: Int = Constants.defaultServings
    
    @Published var newIngredient: (name: String, quantity: Double) = ("", 0)
    @Published var ingredients: [Ingredient] = []
    
    @Published var selectedPhotoItem: PhotosPickerItem? = nil
    @Published var recipeImage: UIImage? = nil
    @Published var isLoadingImage: Bool = false
    
    func loadImage() {
        
        guard let selectedPhotoItem else { return }
        
        isLoadingImage = true
        
        Task {
            if let data = try? await selectedPhotoItem.loadTransferable(type: Data.self) {
                recipeImage = UIImage(data: data)
            }
            isLoadingImage = false
        }
    }
    
    func saveRecipe() {
        let recipeId = generateRecipeID() // Уникальный ID для пользовательских рецептов
        
        // Сохраняем изображение через ImageStorageManager
        let imageURL = saveRecipeImage(recipeId: recipeId)
        
        let newRecipe = createRecipe(id: recipeId, imageURL: imageURL)
        
        DataManager.shared.addRecipe(newRecipe, to: .mine)
        
#if DEBUG
        // Проверяем, что изображение сохранилось
        ImageStorageManager.shared.printStorageInfo()
#endif
        // Очистка формы после сохранения
        resetForm()
    }
    
    // MARK: - Private Methods
    private func generateRecipeID() -> Int {
        Int.random(
            in: Constants.IDRange.userCreatedMin...Constants.IDRange.userCreatedMax
        )
    }
    
    private func saveRecipeImage(recipeId: Int) -> String? {
        guard let recipeImage = recipeImage else { return nil }
        return ImageStorageManager.shared.saveImage(recipeImage, recipeId: recipeId)
    }
    
    private func createRecipe(id: Int, imageURL: String?) -> Recipe {
        Recipe(
            id: id,
            title: title.isEmpty ? Constants.defaultTitle : title,
            instruction: Constants.defaultInstruction,
            instructions: nil,
            author: Constants.authorName,
            spoonacularScore: nil,
            readyInMinutes: readyInMinutes,
            imageURL: imageURL,
            extendedIngredients: ingredients,
            dishTypes: [],
            servings: servings
        )
    }
    
    private func resetForm() {
        title = ""
        readyInMinutes = Constants.defaultReadyInMinutes
        servings = Constants.defaultServings
        ingredients = []
        newIngredient = ("", 0)
        recipeImage = nil
        selectedPhotoItem = nil
    }
}
