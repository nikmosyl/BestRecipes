//
//  RecentCell.swift
//  BestRecipes
//
//  Created by nikita on 25.08.2025.
//

import SwiftUI

struct RecentCell: View {
    @State private var showDetail = false
    
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading) {
            RecipeImageDisplayView(imageURL: recipe.imageURL)
                .frame(width: 124, height: 124)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            
            Spacer()
            
            Text(recipe.title ?? "Empty")
                .font(.custom("Poppins-SemiBold", size: 14))
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
            
            Text("By \(recipe.author ?? "somebody")")
                .font(.custom("Poppins", size: 12))
                .foregroundStyle(Color(hex: "#919191"))
        }
        .navigationDestination(isPresented: $showDetail) {
            RecipeDetailView(recipe: recipe)
        }
        .onTapGesture {
            showDetail = true
        }
    }
}

#Preview {
    RecentCell(recipe: Recipe.previewSample)
        .frame(width: 124, height: 190)
}
