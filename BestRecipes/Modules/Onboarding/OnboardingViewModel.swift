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
            title: "Best Recipes",
            description: "Откройте для себя мир новых вкусов",
            imageName: "Onboarding"
        ),
        Onboarding(
            title: "Рецепты со всех",
            description: "уголков бескрайнего света",
            imageName: "Onboarding1"
        ),
        Onboarding(
            title: "Рецепты буквально",
            description: "расписаны со всеми деталями",
            imageName: "Onboarding2"
        ),
        Onboarding(
            title: "Начни готовить прямо сейчас",
            description: "или сохрани до особого случая",
            imageName: "Onboarding3"
        )
    ]
    
    var isLastPage: Bool {
        return currentPage == items.count - 1
    }
    
    func completeOnboarding() {
        UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
    }
    
    func nextPage() {
        print("Переход на страницу \(currentPage + 1)") // Отладка
        currentPage = min(currentPage + 1, items.count - 1)
    }
    
    func previousPage() {
        currentPage = max(currentPage - 1, 0)
    }
}
