//
//  OnboardingView.swift
//  BestRecipes
//
//  Created by Rook on 12.08.2025.
//

import SwiftUI
import Foundation

// Определяем структуру данных для онбординга
struct Onboarding: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var imageName: String
}

@available(iOS 17.0, *)
@Observable
class OnboardingViewModel {
    var currentPage = 0
    var items: [Onboarding] = [
        Onboarding(title: "Добро пожаловать!",
                   description: "Откройте для себя мир новых возможностей",
                   imageName: "onboarding_1"),
        Onboarding(title: "Основные функции",
                   description: "Изучите все возможности приложения",
                   imageName: "onboarding_2"),
        Onboarding(title: "Начните сейчас",
                   description: "Нажмите кнопку для продолжения",
                   imageName: "onboarding_3")
    ]
    
    var isLastPage: Bool {
        return currentPage == items.count - 1
    }
    
    func completeOnboarding() {
        UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
    }
}

// Пример использования в View
struct OnboardingView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    
    var body: some View {
        TabView(selection: $viewModel.currentPage) {
            ForEach(viewModel.items) { item in
                OnboardingPageView(item: item)
                    .tag(item.id)
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct OnboardingPageView: View {
    let item: Onboarding
    
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
            
            Text(item.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}
