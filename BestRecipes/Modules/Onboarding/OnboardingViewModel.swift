//
//  OnboardingViewModel.swift
//  BestRecipes
//
//  Created by Rook on 12.08.2025.
//

import Foundation
import Combine

class OnboardingViewModel: ObservableObject {
    @Published var currentPage = 0
    @Published var items: [Onboarding] = [
        Onboarding(
            title: "Добро пожаловать!",
            description: "Откройте для себя мир новых возможностей",
            imageName: "Onboarding"
        ),
        Onboarding(
            title: "Основные функции",
            description: "Изучите все возможности приложения",
            imageName: "Onboarding1"
        ),
        Onboarding(
            title: "Начните сейчас",
            description: "Нажмите кнопку для продолжения",
            imageName: "Onboarding2"
        )
    ]
    
    var isLastPage: Bool {
        return currentPage == items.count - 1
    }
    
    func completeOnboarding() {
        UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
    }
    
    func nextPage() {
        currentPage = min(currentPage + 1, items.count - 1)
    }
    
    func previousPage() {
        currentPage = max(currentPage - 1, 0)
    }
}
