//
//  ShowIngredientCheckboxKey.swift
//  BestRecipes
//
//  Created by Aleksandr Meshchenko on 16.08.25.
//

import SwiftUI

// EnvironmentKey + модификатор через Environment.
private struct ShowIngredientCheckboxKey: EnvironmentKey {
    static let defaultValue: Bool = false
}

extension EnvironmentValues {
    var showIngredientCheckbox: Bool {
        get { self[ShowIngredientCheckboxKey.self] }
        set { self[ShowIngredientCheckboxKey.self] = newValue }
    }
}

extension View {
    /// Контролирует отображение чекбокса у IngredientCard
    func ingredientCheckbox(_ show: Bool) -> some View {
        environment(\.showIngredientCheckbox, show)
    }
}
