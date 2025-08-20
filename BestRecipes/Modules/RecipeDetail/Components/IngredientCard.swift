//
//  IngredientCard.swift
//  BestRecipes
//
//  Created by Aleksandr Meshchenko on 16.08.25.
//

import SwiftUI

struct IngredientCard: View {
    let ingredient: Ingredient
    @State private var isChecked = false
    
    var body: some View {
        HStack(spacing: 16) {
            // Image container
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(.systemBackground))
                    .frame(width: 50, height: 50)
                
                AsyncImage(url: ingredientImageURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40) // чуть меньше, чтобы остались поля
                    default:
                        Image(systemName: "leaf")
                            .font(.system(size: 20))
                            .foregroundColor(.gray)
                    }
                }
            }
            
            Text(ingredient.name.capitalized)
                .font(.custom("Poppins-Bold", size: 16))
                .foregroundColor(.primary)
                .lineLimit(2)
            
            Spacer(minLength: 8)
            
            // Amount
            Text("\(ingredient.weight) g")
                .font(.custom("Poppins-Regular", size: 14))
                .foregroundColor(.secondary)
            
            Image(systemName: isChecked ? "checkmark.circle.fill" : "circle")
                .font(.system(size: 24))
                .foregroundColor(isChecked ? .red : .gray.opacity(0.5))
        }
        .padding(16)
        .background(Color.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .contentShape(Rectangle())
        .onTapGesture { isChecked.toggle() } // работаем по всей плашке
    }
    
    private var ingredientImageURL: URL? {
        DataManager.shared.ingredientImageURL(for: ingredient.imageName)
    }
    
    private func formatAmount(_ amount: Double) -> String {
        let f = NumberFormatter()
        f.minimumFractionDigits = 0
        f.maximumFractionDigits = 2
        return f.string(from: NSNumber(value: amount)) ?? "\(amount)"
    }
}

#Preview {
    ScrollView {
        IngredientCard(
            ingredient: Ingredient(
                id: 1,
                name: "Tomato",
                amount: 2.5,
                imageName: "tomato.png"
            )
        )
        .padding()
        .background(Color(.systemBackground))
        
        // Вариант без картинки → проверка leaf-заглушки
        IngredientCard(
            ingredient: Ingredient(
                id: 2,
                name: "Onion",
                amount: 1.0,
                imageName: ""
            )
        )
        .padding()
        .background(Color(.systemBackground))
    }
}
