//
//  RecipeRowView.swift
//  BestRecipes
//
//  Created by Aleksandr Meshchenko on 12.08.25.
//

import SwiftUI

// Карточка рецепта
struct RecipeRowView: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Image with rating and cooking time
            ZStack(alignment: .bottomTrailing) {
                // Recipe Image
                AsyncImage(url: URL(string: recipe.imageURL ?? "")) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure, .empty:
                        Rectangle()
                            .foregroundColor(.gray.opacity(0.2))
                            .overlay(
                                Image(systemName: "photo")
                                    .font(.largeTitle)
                                    .foregroundColor(.gray.opacity(0.5))
                            )
                    @unknown default:
                        ProgressView()
                        //.frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                .frame(height: 180)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                // Градиент внизу
                LinearGradient(
                    colors: [.clear, Color.black.opacity(0.2)],
                    startPoint: .center, endPoint: .bottom
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                // Верхний левый угол — рейтинг
                VStack(alignment: .leading){
                    HStack {
                        ProfileRatingView(rating: recipe.rating)
                        Spacer()
                    }
                    .padding(12)
                    
                    Spacer()
                    
                    // Текст и время внизу
                    VStack(alignment: .leading, spacing: 6) {
                        Text(recipe.title ?? "Unknown Recipe")
                            .font(.custom("Poppins-Bold", size: 20))
                            .foregroundColor(.white)
                            .lineLimit(2)
                        
                        HStack(spacing: 4) {
                            // Количество ингредиентов
                            if let ingredients = recipe.extendedIngredients, !ingredients.isEmpty {
                                Text("\(ingredients.count) Ingredients |")
                                    .font(.custom("Poppins-Regular", size: 12))
                                    .foregroundColor(.white)
                            }
                            
                            // Время готовки
                            if let minutes = recipe.readyInMinutes, minutes > 0 {
                                Text(formatTime(minutes: minutes))
                                    .font(.custom("Poppins-Regular", size: 12))
                                    .foregroundColor(.white)
                                    .padding(.vertical, 4)
                            }
                        }
                    }
                    .padding(12)
                }
                
            }
            .frame(height: 180)
            
        }
        .padding(.vertical, 4)
        .contentShape(Rectangle())
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label)
    }
    
    private var label: String {
        let title = recipe.title ?? "Recipe"
        let time = (recipe.readyInMinutes ?? 0) > 0 ? ", \(recipe.readyInMinutes!) min" : ""
        return "\(title), rating \(String(format: "%.1f", recipe.rating))\(time)"
    }
    
}

private func formatTime(minutes: Int) -> String {
    let hours = minutes / 60
    let mins = minutes % 60
    return hours > 0
    ? String(format: "%dh %02dm", hours, mins)
    : String(format: "%d min", mins)
}

#if DEBUG
struct RecipeRowView_Previews: PreviewProvider {
    static var previews: some View {
        let recipes = Fixtures.loadRecipes(named: "recipes_yam")
        return Group {
            ForEach(recipes.prefix(3), id: \.id) { recipe in
                RecipeRowView(recipe: recipe)
                    .padding()
                    .previewLayout(.sizeThatFits)
            }
        }
        .background(Color(.systemBackground))
    }
}
#endif
