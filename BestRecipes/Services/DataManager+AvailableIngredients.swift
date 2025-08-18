//
//  DataManager+AvailableIngredients.swift
//  BestRecipes
//
//  Created by Aleksandr Meshchenko on 18.08.25.
//

import Foundation

extension DataManager {
    private var availableIngredientsKey: String { "availableIngredients" }
    
    // MARK: - Get Available Ingredients
    func getAvailableIngredients() -> Set<Int> {
        guard let data = UserDefaults.standard.data(forKey: availableIngredientsKey),
              let ids = try? JSONDecoder().decode(Set<Int>.self, from: data) else {
            return []
        }
        return ids
    }
    
    // MARK: - Check if Ingredient is Available
    func isIngredientAvailable(_ ingredientId: Int) -> Bool {
        getAvailableIngredients().contains(ingredientId)
    }
    
    // MARK: - Toggle Ingredient Availability
    func toggleIngredient(_ ingredientId: Int) {
        var availableIds = getAvailableIngredients()
        
        if availableIds.contains(ingredientId) {
            availableIds.remove(ingredientId)
        } else {
            availableIds.insert(ingredientId)
        }
        
        saveAvailableIngredients(availableIds)
    }
    
    // MARK: - Add Ingredient
    func addAvailableIngredient(_ ingredientId: Int) {
        var availableIds = getAvailableIngredients()
        availableIds.insert(ingredientId)
        saveAvailableIngredients(availableIds)
    }
    
    // MARK: - Remove Ingredient
    func removeAvailableIngredient(_ ingredientId: Int) {
        var availableIds = getAvailableIngredients()
        availableIds.remove(ingredientId)
        saveAvailableIngredients(availableIds)
    }
    
    // MARK: - Clear All Available Ingredients
    func clearAllAvailableIngredients() {
        UserDefaults.standard.removeObject(forKey: availableIngredientsKey)
    }
    
    // MARK: - Private Helper
    private func saveAvailableIngredients(_ ids: Set<Int>) {
        if let data = try? JSONEncoder().encode(ids) {
            UserDefaults.standard.set(data, forKey: availableIngredientsKey)
        }
    }
}
