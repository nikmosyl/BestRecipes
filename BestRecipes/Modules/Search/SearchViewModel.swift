//
//  SearchViewModel.swift
//  BestRecipes
//
//  Created by Николай Игнатов on 18.08.2025.
//

import Foundation

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var searchState: SearchViewState = .initial
    
    func searchRecipes(query: String) async {
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedQuery.isEmpty else {
            searchState = .initial
            return
        }
        
        searchState = .loading
        
        do {
            let result = try await DataManager.shared.getRecipes(type: .search, by: trimmedQuery)
            recipes = result
            searchState = .loaded(result)
        } catch {
            let message = "Ошибка загрузки: \(error.localizedDescription)"
            searchState = .error(message)
        }
    }
}
