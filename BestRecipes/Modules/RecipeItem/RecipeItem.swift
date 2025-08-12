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

struct RecipeItem: View {
    var recipe: Recipe
    var showCookingTime: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .bottomTrailing) {
                AsyncImage(url: URL(string: recipe.imageURL ?? "")) { image in
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
                        RatingView(rating: recipe.rating)
                        Spacer()
                        BookmarkButton {
                            /*при срабатывании кнопки будет предаваться в соответствующий менеджер recipe.id
                             */
                            print("--> tapped bookmark button")
                        }
                    }
                    Spacer()
                }
                .padding()
                
                
                if showCookingTime {
                    CookingTimeView(cookingInMinutes: recipe.readyInMinutes ?? 0)
                        .padding()
                }
            }
            .frame(height: 200)
            
            Text("\(recipe.title ?? "unknown")")
                .lineLimit(1)
                .font(.custom("Poppins-SemiBold", size: 16))
            
            HStack {
                Rectangle()
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                    .foregroundStyle(.gray)
                
                Text(recipe.author ?? "Unknown")
                    .font(.custom("Poppins-Regular", size: 12))
                    .foregroundStyle(.secondary)
                
                Spacer()
            }
        }
        .padding()
    }
}


#Preview {
    RecipeItem(
        recipe: Recipe(
            id: 642583,
            title: "Farfalle with Peas, Ham and Cream",
            instruction: nil,
            instructions: [],
            author: "By Zeelicious Foods",
            spoonacularScore: 47.98303985595703,
            readyInMinutes: 30,
            imageURL: "https://img.spoonacular.com/recipes/642583-312x231.jpg",
            extendedIngredients: [],
            dishTypes: [
                "side dish",
                "lunch",
                "main course",
                "main dish",
                "dinner"
            ],
            servings: 4
        ),
        showCookingTime: true
    )
}
