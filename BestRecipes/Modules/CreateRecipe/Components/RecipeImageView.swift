//
//  RecipeImageView.swift
//  BestRecipes
//
//  Created by Иван Семикин on 15/08/2025.
//

import SwiftUI
import PhotosUI

struct RecipeImageView: View {
    @EnvironmentObject private var viewModel: CreateRecipeViewModel
    
    var body: some View {
        Group {
            if let uiImage = viewModel.recipeImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(alignment: .topTrailing) {
                        PhotosPicker(selection: $viewModel.selectedPhotoItem, matching: .images) {
                            Image(systemName: "camera.on.rectangle")
                                .padding(8)
                                .foregroundStyle(.white)
                                .background(.ultraThinMaterial, in: Circle())
                        }
                        .padding(10)
                    }
                    .onChange(of: viewModel.selectedPhotoItem) { newValue in
                        viewModel.loadImage()
                    }
                    .padding()
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [6]))
                        .foregroundStyle(.gray.opacity(0.35))
                        .frame(height: 200)
                    
                    VStack(spacing: 8) {
                        Image(systemName: "photo.on.rectangle.angled")
                            .font(.system(size: 28, weight: .semibold))
                        
                        Text("Add recipe photo")
                            .font(.subheadline)
                    }
                    .foregroundStyle(.gray)
                    
                    if viewModel.isLoadingImage {
                        ProgressView()
                            .progressViewStyle(.circular)
                    }
                }
                .padding()
                .overlay {
                    PhotosPicker(selection: $viewModel.selectedPhotoItem, matching: .images) {
                        Color.clear
                    }
                }
                .onChange(of: viewModel.selectedPhotoItem) { newValue in
                    viewModel.loadImage()
                }
            }
        }
    }
}

#Preview {
    RecipeImageView()
        .environmentObject(CreateRecipeViewModel())
}
