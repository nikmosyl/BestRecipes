//
//  CreateRecipeView.swift
//  BestRecipes
//
//  Created by Иван Семикин on 12/08/2025.
//

import SwiftUI
import PhotosUI

struct CreateRecipeView: View {
    @StateObject private var viewModel = CreateRecipeViewModel()
    
    var body: some View {
        ScrollView {
            RecipeImageView()
            
            TextField("Title", text: $viewModel.title)
                .padding(.vertical, 8)
                .padding(.horizontal)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(style: StrokeStyle(lineWidth: 1))
                        .foregroundStyle(.red)
                }
                .padding(.horizontal)
        }
        .environmentObject(viewModel)
        .navigationTitle("Create Recipe")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    // TODO: Implement navigation back
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundStyle(.black)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CreateRecipeView()
    }
}
