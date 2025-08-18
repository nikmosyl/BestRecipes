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
    //@AppStorage("savedRecipes") private var savedRecipesData: Data = Data()
    
    @Published var savedRecipesData = DataManager.shared.getRecipesFrom(.mine)
    
    @Published var title: String = ""
    
    @Published var showCookTimePicker: Bool = false
    @Published var readyInMinutes: Int = 20
    
    @Published var showServesPicker: Bool = false
    @Published var servings: Int = 1
    
    @Published var newIngredient: (name: String, quantity: Double) = ("", 0)
    @Published var ingredients: [Ingredient] = []

    @Published var selectedPhotoItem: PhotosPickerItem? = nil
    @Published var recipeImage: UIImage? = nil
    @Published var isLoadingImage: Bool = false
    
    func loadImage() {
        print("loadImage() was called")
        guard let selectedPhotoItem else { return }
        print("First guard was passed")
        
        isLoadingImage = true
        
        Task {
            if let data = try? await selectedPhotoItem.loadTransferable(type: Data.self) {
                recipeImage = UIImage(data: data)
                print("recipeImage is ready")
            }
            isLoadingImage = false
        }
    }
    
    func saveRecipe() {
        var imageBase64: String? = nil
        if let recipeImage, let imageData = recipeImage.jpegData(compressionQuality: 0.8) {
            imageBase64 = imageData.base64EncodedString()
        }

        let newRecipe = Recipe(
            id: Int.random(in: 1...10_000),
            title: title,
            instruction: "",
            instructions: nil,
            author: "Mine",
            spoonacularScore: nil,
            readyInMinutes: readyInMinutes,
            imageURL: imageBase64,
            extendedIngredients: ingredients,
            dishTypes: [],
            servings: servings
        )

        DataManager.shared.addRecipe(newRecipe, to: .mine)
    }
}
