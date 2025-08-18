//
//  RecipeDetailState.swift
//  BestRecipes
//
//  Created by Aleksandr Meshchenko on 16.08.25.
//

struct RecipeDetailState {
    var recipe: Recipe
    var isBookmarked: Bool = false
    var isLoading: Bool = false
    var errorMessage: String?
}
