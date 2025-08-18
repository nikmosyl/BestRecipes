//
//  SearchView.swift
//  BestRecipes
//
//  Created by Николай Игнатов on 18.08.2025.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @StateObject private var viewModel = SearchViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            searchHeader
            searchContent
        }
        .background(Color(.systemBackground))
    }
}

// MARK: - Private Views
private extension SearchView {
    var loadingView: some View {
        VStack(spacing: 20) {
            Spacer()
            
            ProgressView()
                .scaleEffect(1.2)
                .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
            
            Text("Ищем рецепты...")
                .font(.custom("Poppins-Regular", size: 16))
                .foregroundColor(.secondary)
            
            Spacer()
        }
    }
    
    var searchHeader: some View {
        VStack(spacing: 16) {
            SearchFieldView(searchText: $searchText) {
                dismiss()
            }
            .onChange(of: searchText) { _ in
                performSearch()
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
    }
    
    @ViewBuilder
    var searchContent: some View {
        switch viewModel.searchState {
        case .initial:
            centerText("Введите поисковый запрос")
            
        case .loading:
            loadingView
            
        case .loaded(let recipes):
            if recipes.isEmpty {
                centerText("Рецепты не найдены")
            } else {
                recipesList(recipes)
            }
            
        case .error(let message):
            centerText(message)
        }
    }
}

// MARK: - Private Methods
private extension SearchView {
    func centerText(_ text: String) -> some View {
        VStack {
            Spacer()
            Text(text)
                .font(.custom("Poppins-Regular", size: 16))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
    
    func recipesList(_ recipes: [Recipe]) -> some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(recipes, id: \.id) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                        RecipeRowView(recipe: recipe)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
    }
    
    func performSearch() {
        guard !searchText.isEmpty else { return }
        Task {
            await viewModel.searchRecipes(query: searchText)
        }
    }
}

#if DEBUG
#Preview {
    SearchView()
}
#endif
