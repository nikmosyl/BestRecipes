//
//  RecipeImageDisplayView.swift
//  BestRecipes
//
//  Created by Aleksandr Meshchenko on 23.08.25.
//

import SwiftUI

// Универсальный View для отображения изображений из разных источников

struct RecipeImageDisplayView: View {
    let imageURL: String?
    
    var body: some View {
        if let imageURL = imageURL {
            if imageURL.hasPrefix("http://") || imageURL.hasPrefix("https://") {
                // Внешний URL (API Spoonacular)
                AsyncImage(url: URL(string: imageURL)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure, .empty:
                        placeholderView
                    @unknown default:
                        ProgressView()
                    }
                }
            } else if imageURL.hasPrefix("local://") {
                // Локальный файл через ImageStorageManager (созданные пользователем рецепты)
                if let uiImage = ImageStorageManager.shared.loadImage(from: imageURL) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                } else {
                    // Неизвестный формат
                    placeholderView
                }
            } else {
                // Неизвестный формат
                placeholderView
            }
        } else {
            // Нет изображения
            placeholderView
        }
    }
    
    private var placeholderView: some View {
        Rectangle()
            .foregroundColor(.gray.opacity(0.2))
            .overlay(
                Image(systemName: "photo")
                    .font(.largeTitle)
                    .foregroundColor(.gray.opacity(0.5))
            )
    }
}
