//
//  Untitled.swift
//  BestRecipes
//
//  Created by Rook on 12.08.2025.
//

import SwiftUI

struct OnboardingPageView: View {
    let item: Onboarding
    
    var body: some View {
        ZStack {
            // Фоновое изображение
            Image(item.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: .infinity, height: .infinity)
                .ignoresSafeArea()
                .clipped()
                .overlay(
                    Color.black.opacity(0.3)
                )
            
            // Контент поверх изображения
            VStack(spacing: 0) {
                Spacer()
                
                // Заголовок
                Text(item.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 8)
                    .padding(.horizontal, 24)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.black.opacity(0.5))
                    }
                
                // Описание
                Text(item.description)
                    .font(.body)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.black.opacity(0.5))
                    }
                
                Spacer()
            }
            .padding(0) // Полностью убираем все отступы
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .ignoresSafeArea()
    }
}
