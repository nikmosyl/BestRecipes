//
//  Untitled.swift
//  BestRecipes
//
//  Created by Rook on 12.08.2025.
//

import SwiftUI

struct OnboardingPageView: View {
    let item: OnboardingModel
    
    var body: some View {
            VStack(spacing: 14) {
                Spacer()
                
                VStack(alignment: .center) {
                    Text(item.title)
                        .font(.custom("Poppins-SemiBold", size: 40))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        
                    Text(item.description)
                        .font(.custom("Poppins-SemiBold", size: 40))
                        .foregroundColor(Color(hex: "#F8C89A"))
                        .multilineTextAlignment(.center)
                }
                .padding(20)
                
                Spacer()
            }
        .ignoresSafeArea()
        .background {
            Image(item.imageName)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()
                .overlay(
                    Color.black.opacity(0.3)
                )
                .ignoresSafeArea()
        }
    }
}

#Preview {
    OnboardingPageView(
        item: OnboardingModel(
            title: "Тестирование длинного текста который может не влезть",
            description: "Тестирование описания которое может не влезть",
            imageName: "Onboarding"
        )
    )
}
