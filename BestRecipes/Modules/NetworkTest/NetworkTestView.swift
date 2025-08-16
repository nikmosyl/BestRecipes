//
//  NetworkTestView.swift
//  BestRecipes
//
//  Created by nikita on 10.08.2025.
//

import SwiftUI

#warning("Будет удалён 24.08.2025")

struct NetworkTestView: View {
    @StateObject private var viewModel = NetworkTestViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    if viewModel.isLoading {
                        ProgressView("Загрузка...")
                            .padding()
                    } else if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .padding()
                    } else {
                        ForEach(viewModel.recipes, id: \.id) { recipe in
                            RecipeItem(
                                recipe: recipe,
                                showCookingTime: true,
                                isBookmarked: viewModel.checkBookmarked(id: recipe.id)
                            )
                        }
                    }
                }
                .onAppear {
                    viewModel.fetchBookmarkedRecipes()
                }
                .navigationTitle("Рецепты")
                .task {
                    await viewModel.loadRecipes()
                }
            }
        }
    }
}


#Preview {
    NetworkTestView()
}
