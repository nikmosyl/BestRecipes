//
//  ProfileModule.swift
//  BestRecipes
//
//  Created by Aleksandr Meshchenko on 12.08.25.
//

import SwiftUI

/// Модуль для работы с профилем пользователя
///
/// Предоставляет публичный API для создания и управления экраном профиля.
/// Модуль инкапсулирует всю внутреннюю логику работы с профилем.
///
/// - Note: Используется паттерн Factory для создания View
/// - Important: Все внутренние компоненты (ProfileView, ProfileViewModel) остаются internal
public struct ProfileModule {
    
    // MARK: - View Factory
    
    /// Создает экран профиля пользователя
    ///
    /// - Returns: View с профилем пользователя, включающий фото и список рецептов
    ///
    /// - Note: View автоматически обновляется при изменении данных
    @MainActor
    public static func makeProfileView() -> some View {
        ProfileView()
    }
    
    // MARK: - Data Access
    
    /// Проверяет наличие сохраненных рецептов у пользователя
    ///
    /// - Returns: `true` если есть хотя бы один сохраненный рецепт, иначе `false`
    public static func hasUserRecipes() -> Bool {
        !DataManager.shared.getRecipesFrom(.mine).isEmpty
    }
    
    /// Возвращает количество сохраненных рецептов пользователя
    ///
    /// - Returns: Количество рецептов в профиле
    public static func userRecipesCount() -> Int {
        DataManager.shared.getRecipesFrom(.mine).count
    }
}

// MARK: - Usage Examples

/*
 Интеграция в TabView:
 ```swift
 TabView(selection: $selectedTab) {
     ProfileModule.makeProfileView()
         .tabItem {
             Label("Profile", systemImage: "person.circle")
         }
         .tag(Tab.profile)
 }
 ```
 
 Отображение счетчика рецептов:
 ```swift
 if ProfileModule.hasUserRecipes() {
     HStack {
         Image(systemName: "book.fill")
         Text("\(ProfileModule.userRecipesCount()) recipes")
     }
 }
 ```
 
 Условное отображение контента:
 ```swift
 VStack {
     if ProfileModule.hasUserRecipes() {
         Text("You have \(ProfileModule.userRecipesCount()) recipes")
     } else {
         Text("Start creating your first recipe!")
     }
 }
 ```
 */
