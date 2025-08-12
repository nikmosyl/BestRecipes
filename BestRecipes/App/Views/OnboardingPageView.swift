//
//  Untitled.swift
//  BestRecipes
//
//  Created by Rook on 12.08.2025.
//

import SwiftUI

struct OnboardingPageView: View {
    let item: OnboardingItem
    
    var body: some View {
        VStack(spacing: 20) {
            Image(item.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 300)
                .cornerRadius(16)
                .padding()
            
            Text(item.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            Text(item.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}
