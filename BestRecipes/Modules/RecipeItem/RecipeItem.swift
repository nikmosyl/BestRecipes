//
//  RecipeItem.swift
//  BestRecipes
//
//  Created by Mikhail Ustyantsev on 11.08.2025.
//

import SwiftUI

struct RecipeItem: View {
    var recipe: Recipe
    
    var body: some View {
        GeometryReader { reader in
            VStack(alignment: .leading) {
                ZStack(alignment: .topLeading) {
                    AsyncImage(url: URL(string: recipe.imageURL ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: reader.size.width * 0.9, height: reader.size.height * 0.25)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                            .frame(width: reader.size.width * 0.9, height: reader.size.height * 0.25)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    HStack {
                        RatingView(rating: recipe.rating)
                        
                        Spacer()
                        
                        BookmarkButton {
                            print("--> tapped bookmark button")
                        }
                    }
                    .padding()
                }
                
                Text("\(recipe.title ?? "unknown")")
                    .lineLimit(1)
                    .font(.custom("Poppins-SemiBold", size: 16))
                    .foregroundStyle(.primary)
                
                HStack {
                    //placeholder для будущей картинки
                    Rectangle()
                        .frame(width: reader.size.width * 0.1, height: reader.size.width * 0.1)
                        .clipShape(Circle())
                        .foregroundStyle(.gray)
                    
                    Text(recipe.author ?? "Unknown")
                        .font(.custom("Poppins-Regular", size: 12))
                        .foregroundStyle(.secondary)
                    
                    Spacer()
                }
            }
            .frame(
                width: reader.size.width * 0.9,
                height: reader.size.height * 0.3
            )
            .frame(maxWidth: .infinity, alignment: .center)
        }
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
        )
    )
}
