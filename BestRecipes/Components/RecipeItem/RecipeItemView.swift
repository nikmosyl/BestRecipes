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
                
                //if showCookingTime {
                CookingTimeView(
                    cookingInMinutes: viewModel.recipe.readyInMinutes ?? 0
                )
                    .padding()
                //}
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
        .onAppear {
            viewModel.onAppear()
        }
        //.padding()
    }
}


#Preview {
//    RecipeItemView(
//        recipe: Recipe(
//            id: 642583,
//            title: "Farfalle with Peas, Ham and Cream",
//            instruction: nil,
//            instructions: [],
//            author: "By Zeelicious Foods",
//            spoonacularScore: 47.98303985595703,
//            readyInMinutes: 30,
//            imageURL: "https://img.spoonacular.com/recipes/642583-312x231.jpg",
//            extendedIngredients: [],
//            dishTypes: [
//                "side dish",
//                "lunch",
//                "main course",
//                "main dish",
//                "dinner"
//            ],
//            servings: 4
//        ),
//        //showCookingTime: true,
//        isBookmarked: true
//    )
    RecipeItemView(recipe: Recipe.previewSample)
}
