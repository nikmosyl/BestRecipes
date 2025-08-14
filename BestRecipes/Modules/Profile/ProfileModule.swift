//
//  ProfileModule.swift
//  BestRecipes
//
//  Created by Aleksandr Meshchenko on 12.08.25.
//

import SwiftUI

/// Публичный API модуля Profile
public struct ProfileModule {
    
    /// Создает и возвращает главный View модуля
    /// фабрика/роутинг 
    @MainActor public static func makeProfileView() -> some View {
        ProfileView()
    }
    
    /// Проверяет, есть ли сохраненные рецепты пользователя
    public static func hasUserRecipes() -> Bool {
        !StorageManager.shared.getRecipesFrom(.mine).isEmpty
    }
    
    /// Возвращает количество сохраненных рецептов
    public static func userRecipesCount() -> Int {
        StorageManager.shared.getRecipesFrom(.mine).count
    }
}
