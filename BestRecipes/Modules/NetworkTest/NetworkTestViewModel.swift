//
//  NetworkTestViewModel.swift
//  BestRecipes
//
//  Created by nikita on 10.08.2025.
//

import Foundation

#warning("Будет удалён 24.08.2025")

@MainActor
final class NetworkTestViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var errorMessage: String?
    @Published var isLoading = false
    //saved array "Bookmarked"
    var bookmarkedRecipes: [Recipe] = []
    
    func loadRecipes(query: String = "pasta") async {
        isLoading = true
        errorMessage = nil
        
        do {
            let result = try await DataManager.shared.getRecipes(type: .search, by: query)
            recipes = result
        } catch {
            errorMessage = "Ошибка загрузки: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    
    func checkBookmarked(id: Int) -> Bool {
        bookmarkedRecipes.contains { $0.id == id }
    }
    
    func fetchBookmarkedRecipes() {
        bookmarkedRecipes = DataManager.shared.getRecipesFrom(.favorites)
    }
}
