//
//  CategorySection.swift
//  BestRecipes
//
//  Created by nikita on 24.08.2025.
//

import SwiftUI

struct CategorySection: View {
    @Binding var currentCategory: MealType
    
    let categories: [MealType]
    var recipes: [Recipe]
    
    var body: some View {
        HStack {
            Text("Popular category ")
                .font(.custom("Poppins-SemiBold", size: 20))
            
            Spacer()
        }
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(categories, id: \.self) { category in
                    Button {
                        currentCategory = category
                    } label: {
                        Text(category.rawValue)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(
                                category == currentCategory
                                ? Color(hex: "#E23E3E")
                                : Color.clear
                            )
                            .cornerRadius(10)
                            .foregroundColor(
                                category == currentCategory
                                ? Color.white
                                : Color(hex: "#F3B2B2")
                            )
                    }
                }
            }
        }
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(recipes, id: \.id) { recipe in
                    CategoryCell(recipe: recipe)
                        .frame(width: 150, height: 231)
                }
            }
        }
    }
}

#Preview {
    CategorySection(
        currentCategory: .constant(.mainCourse),
        categories: MealType.allCases,
        recipes: Array(repeating: Recipe.previewSample, count: 20)
    )
}
