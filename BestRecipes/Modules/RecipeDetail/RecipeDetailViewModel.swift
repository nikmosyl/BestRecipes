//
//  RecipeDetailViewModel.swift
//  BestRecipes
//
//  Created by Aleksandr Meshchenko on 16.08.25.
//

import SwiftUI

@MainActor
final class RecipeDetailViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published private(set) var state: RecipeDetailState
    
    // MARK: - Private Properties
    private let dataManager = DataManager.shared
    
    // MARK: - Initialization
    
    init(recipe: Recipe) {
        self.state = RecipeDetailState(recipe: recipe)
    }
    
    // MARK: - Computed Properties
    
    var recipe: Recipe { state.recipe }

    var isLoading: Bool { state.isLoading }
}
