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
        VStack() {
            // Секция с изображением
            ZStack {
                Image(item.imageName)
                    .resizable()
                    .scaledToFill() // Масштабируем чтобы заполнить всё пространство
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped() // Обрезаем лишнее
                    .edgesIgnoringSafeArea(.all) // Игнорируем безопасные зоны
                    
                // Добавляем контент поверх изображения
                VStack(spacing: 24) {
                    Spacer()
                    
                    // Секция с заголовком
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
                    
                    // Секция с описанием
                    Text(item.description)
                        .font(.body)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.black.opacity(0.5))
                        }
                }
            }
            
        }
        .background(Color.black.opacity(0.8)) // Добавляем темный фон для контраста
    }
}
