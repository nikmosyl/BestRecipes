//
//  RecipeItemViewModel.swift
//  BestRecipes
//
//  Created by nikita on 20.08.2025.
//

import Foundation

final class RecipeItemViewModel: ObservableObject {
    @Published var recipe: Recipe
    @Published var isBookmarked: Bool
    
    init(recipe: Recipe) {
        self.recipe = recipe
        isBookmarked = DataManager.shared.getRecipesFrom(.favorites).contains(where: { bookmark in
            bookmark.id == recipe.id
        })
    }
    
    func onAppear() {
        isBookmarked = DataManager.shared.getRecipesFrom(.favorites).contains(where: { bookmark in
            bookmark.id == recipe.id
        })
    }
    
    func toggleBookmark() {
        if isBookmarked {
            DataManager.shared.deleteRecipe(recipe, from: .favorites)
            isBookmarked = false
        } else {
            DataManager.shared.addRecipe(recipe, to: .favorites)
            isBookmarked = true
        }
    }
}
