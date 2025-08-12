//
//  CreateRecipeViewModel.swift
//  BestRecipes
//
//  Created by Иван Семикин on 12/08/2025.
//

import Foundation
import PhotosUI
import _PhotosUI_SwiftUI

final class CreateRecipeViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var author: String = ""
    @Published var readyInMinutes: Int? = nil
    @Published var servings: Int? = nil
    @Published var dishTypes: [String] = []
    
    @Published var instruction: String = ""
    @Published var instructions: [Instruction] = []
    
    @Published var ingredients: [Ingredient] = []
    
    @Published var selectedPhotoItem: PhotosPickerItem? = nil
    @Published var recipeImage: UIImage? = nil
    @Published var isLoadingImage: Bool = false
}
