//
//  HomeViewModel.swift
//  BestRecipes
//
//  Created by nikita on 20.08.2025.
//

import Foundation

final class HomeViewModel: ObservableObject {
    @Published var trandings: [Recipe] = Array(repeating: Recipe.previewSample, count: 10)
    
    @Published var currentCategory = MealType.mainCourse
    @Published var categoryes = MealType.allCases
    @Published var categoryRecipes: [Recipe] = Array(repeating: Recipe.previewSample, count: 10)
    
    @Published var recents: [Recipe] = DataManager.shared.getRecipesFrom(.recent)
}
