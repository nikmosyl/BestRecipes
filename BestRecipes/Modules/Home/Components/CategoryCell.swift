//
//  CategoryCell.swift
//  BestRecipes
//
//  Created by nikita on 25.08.2025.
//

import SwiftUI

struct CategoryCell: View {
    @State private var isBookmarked: Bool
    
    let recipe: Recipe
    
    init(recipe: Recipe) {
        isBookmarked = DataManager.shared.getRecipesFrom(.favorites).contains(where: { bookmark in
            bookmark.id == recipe.id
        })
        
        self.recipe = recipe
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color(hex: "#F1F1F1"))
                .cornerRadius(12)
                .padding(.top, 55)
            
            VStack {
                AsyncImage(url: URL(string: recipe.imageURL ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ZStack {
                        Color.clear
                        ProgressView()
                    }
                }
                .frame(width: 110, height: 110)
                .clipShape(RoundedRectangle(cornerRadius: 110/2))
                
                Text(recipe.title ?? "Empty")
                    .font(.custom("Poppins-SemiBold", size: 14))
                    .padding(.horizontal, 12)
                
                Spacer()
                
                HStack {
                    Text("Time")
                        .font(.custom("Poppins-SemiBold", size: 14))
                        .padding(.horizontal, 12)
                        .foregroundStyle(Color(hex: "#C1C1C1"))
                    Spacer()
                }
                
                HStack {
                    Text("\(recipe.readyInMinutes ?? 5) Mins")
                        .font(.custom("Poppins-SemiBold", size: 14))
                    
                    Spacer()
                    
                    BookmarkButton(isBookmarked: $isBookmarked) {
                        if isBookmarked {
                            DataManager.shared.deleteRecipe(recipe, from: .favorites)
                            isBookmarked = false
                        } else {
                            DataManager.shared.addRecipe(recipe, to: .favorites)
                            isBookmarked = true
                        }
                    }
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 12)
                
            }
        }
    }
}

#Preview {
    CategoryCell(recipe: Recipe.previewSample)
        .frame(width: 150, height: 231)
}
