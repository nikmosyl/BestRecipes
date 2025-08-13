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
        VStack(spacing: 24) {
            // Секция с изображением
            ZStack {
                Image(item.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                    .cornerRadius(16)
                    .padding(.horizontal, 24)
            }
            .padding(.top, 40)
            
            // Секция с заголовком
            Text(item.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.bottom, 8)
            
            // Секция с описанием
            Text(item.description)
                .font(.body)
        }
    }
}
