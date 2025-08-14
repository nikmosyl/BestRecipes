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
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .clipped()
                .overlay(
                    Color.black.opacity(0.3)
                )
            
            // Контент поверх изображения
            VStack(spacing: 24) { // Увеличиваем пространство между элементами
                Spacer()
                
                // Заголовок и описание в вертикальном стеке
                VStack(alignment: .center) { // Центрируем по горизонтали
                    Text(item.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 8)
                        
                    Text(item.description)
                        .font(.body)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 24) // Отступы по бокам
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle()) // Для правильного определения размера
        }
        .ignoresSafeArea()
    }
}

#Preview {
    OnboardingView()
}
