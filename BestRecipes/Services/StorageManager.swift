//
//  StorageManager.swift
//  BestRecipes
//
//  Created by nikita on 10.08.2025.
//

import Foundation

enum SavedRecipesType: String {
    case mine = "myRecipes"
    case favorites = "favoritesRecipes"
    case recent = "recentRecipes"
}

final class StorageManager {
    static let shared = StorageManager()
    
    private init() {}
    
    func getRecipesFrom(_ storage: SavedRecipesType) -> [Recipe] {
        if let recipesData = UserDefaults.standard.data(forKey: storage.rawValue),
           let recipes = try? JSONDecoder().decode([Recipe].self, from: recipesData) {
            return recipes
        }
        return []
    }
    
    func addRecipe(_ recipe: Recipe, to storage: SavedRecipesType) {
        var recipes = getRecipesFrom(storage)
        
        if recipes.contains(where: { $0.id == recipe.id }) { return }
        
        recipes.append(recipe)
        
        if let item = try? JSONEncoder().encode(recipes) {
            UserDefaults.standard.set(item, forKey: storage.rawValue)
        }
    }
    
    func deleteRecipe(_ recipe: Recipe, from storage: SavedRecipesType) {
        var recipes = getRecipesFrom(storage)
        
        guard let index = recipes.firstIndex(where: { $0.id == recipe.id }) else { return }
        recipes.remove(at: index)
        
        if let item = try? JSONEncoder().encode(recipes) {
            UserDefaults.standard.set(item, forKey: storage.rawValue)
        }
    }
}
