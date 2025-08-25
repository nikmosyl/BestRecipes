//
//  HomeViewModel.swift
//  BestRecipes
//
//  Created by nikita on 20.08.2025.
//

import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var searchResult: [Recipe] = []
    
    @Published var trandings: [Recipe] = []
    
    @Published var currentCategory = MealType.mainCourse {
        didSet {
            Task { await loadCategoryRecipes() }
        }
    }
    @Published var categoryes = MealType.allCases
    @Published var categoryRecipes: [Recipe] = []
    
    init() {
        loadTrendings()
        Task { await loadCategoryRecipes() }
    }
    
    private func loadTrendings() {
        Task {
            do {
                let recipes = try await DataManager.shared.getRecipes(type: .trend)
                self.trandings = recipes
            } catch {
                print("Ошибка при загрузке трендовых рецептов: \(error)")
            }
        }
    }
    
    func loadCategoryRecipes() async {
        do {
            let recipes = try await DataManager.shared.getRecipes(type: .type, by: currentCategory.rawValue)
            self.categoryRecipes = recipes
        } catch {
            print("Ошибка при загрузке рецептов категории \(currentCategory.rawValue): \(error)")
            self.categoryRecipes = []
        }
    }
    
    func search() {
        Task {
            do {
                let searchResult = try await DataManager.shared.getRecipes(type: .search, by: searchText)
                self.searchResult = searchResult
            } catch {
                print("Ошибка при загрузке трендовых рецептов: \(error)")
            }
        }
    }
}
