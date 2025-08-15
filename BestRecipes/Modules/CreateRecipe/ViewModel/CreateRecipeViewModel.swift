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
    @Published var title: String = ""
    @Published var author: String = ""
    
    @Published var showCookTimePicker: Bool = false
    @Published var readyInMinutes: Int = 10
    
    @Published var showServesPicker: Bool = false
    @Published var servings: Int = 0
    
    @Published var instruction: String = ""
    @Published var instructions: [Instruction] = []
    
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
}
