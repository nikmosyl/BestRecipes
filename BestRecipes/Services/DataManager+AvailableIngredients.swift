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
        guard let ids: Set<Int> = FileManager.load(Set<Int>.self, from: availableIngredientsKey) else {
            return []
        }
        return ids
    }
    
    // MARK: - Check if Ingredient is Available
    func isIngredientAvailable(_ ingredientId: Int) -> Bool {
        let result = getAvailableIngredients().contains(ingredientId)
        return result
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
        let url = FileManager.documentsDirectory.appendingPathComponent(availableIngredientsKey)
        try? FileManager.default.removeItem(at: url)
    }
    
    // MARK: - Private Helper
    private func saveAvailableIngredients(_ ids: Set<Int>) {
        FileManager.save(ids, as: availableIngredientsKey)
    }
}
