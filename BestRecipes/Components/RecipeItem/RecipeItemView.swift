//
//  RecipeItem.swift
//  BestRecipes
//
//  Created by Mikhail Ustyantsev on 11.08.2025.
//

import SwiftUI

/// Ячейка, отображающая карточку рецепта с изображением, названием, автором, оценкой и (опционально) временем приготовления.
///
/// - Параметры:
/// - recipe: объект типа Recipe
/// - showCookingTime: логический флаг, управляющий отображением времени приготовления.
/// Установите значение `true`, если время приготовления должно быть видно (например, в сохраненных рецептах),
/// и `false`, если оно должно быть скрыто (например, горизонтальная коллекция Trending now 🔥).

struct RecipeItemView: View {
    @StateObject private var viewModel: RecipeItemViewModel
    @State private var showDetail = false
    
    init(recipe: Recipe) {
        _viewModel = StateObject(wrappedValue: RecipeItemViewModel(recipe: recipe))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .bottomTrailing) {
                AsyncImage(url: URL(string: viewModel.recipe.imageURL ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipped()
                } placeholder: {
                    ZStack {
                        Color.clear
                        ProgressView()
                            .frame(height: 200)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack {
                    HStack {
                        RatingView(rating: viewModel.recipe.rating)
                        Spacer()
                        BookmarkButton(isBookmarked: $viewModel.isBookmarked) {
                            viewModel.toggleBookmark()
                        }
                    }
                    Spacer()
                }
                .padding()
                
                CookingTimeView(
                    cookingInMinutes: viewModel.recipe.readyInMinutes ?? 0
                )
                    .padding()
            }
            .frame(height: 200)
            
            Text("\(viewModel.recipe.title ?? "unknown")")
                .lineLimit(1)
                .font(.custom("Poppins-SemiBold", size: 16))
            
            HStack {
                Image("authorPlaceholder")
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                    .foregroundStyle(.gray)
                
                Text(viewModel.recipe.author ?? "Unknown")
                    .font(.custom("Poppins-Regular", size: 12))
                    .foregroundStyle(.secondary)
                
                Spacer()
            }
        }
        .navigationDestination(isPresented: $showDetail) {
            RecipeDetailView(recipe: viewModel.recipe)
        }
        .onAppear {
            viewModel.onAppear()
        }
        .onTapGesture {
            showDetail = true
        }
    }
}


#Preview {
    RecipeItemView(recipe: Recipe.previewSample)
}
