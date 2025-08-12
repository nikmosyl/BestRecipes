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
            VStack {
                if viewModel.isLoading {
                    ProgressView("Загрузка...")
                        .padding()
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    List(viewModel.recipes, id: \.id) { recipe in
                        HStack(spacing: 12) {
                            AsyncImage(url: URL(string: recipe.imageURL ?? "")) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(width: 60, height: 60)
                                case .success(let image):
                                    image.resizable()
                                        .scaledToFill()
                                        .frame(width: 60, height: 60)
                                        .cornerRadius(8)
                                case .failure:
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 60, height: 60)
                                        .foregroundColor(.gray)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(recipe.title ?? "Без названия")
                                    .font(.headline)
                                
                                if let time = recipe.readyInMinutes {
                                    Text("⏱ \(time) мин")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                
                                if let servings = recipe.servings {
                                    Text("Порций: \(servings)")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Рецепты")
            .task {
                await viewModel.loadRecipes()
            }
        }
    }
}


#Preview {
    NetworkTestView()
}
