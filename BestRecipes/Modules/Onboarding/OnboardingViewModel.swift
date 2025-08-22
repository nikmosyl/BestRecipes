//
//  OnboardingViewModel.swift
//  BestRecipes
//
//  Created by Rook on 12.08.2025.
//

import Foundation

final class OnboardingViewModel: ObservableObject {
    @Published var currentPage = 0
    @Published var items: [OnboardingModel] = [
        OnboardingModel(
            title: "Best Recipes",
            description: "Откройте для себя мир новых вкусов",
            imageName: "Onboarding"
        ),
        OnboardingModel(
            title: "Рецепты со всех",
            description: "уголков бескрайнего света",
            imageName: "Onboarding1"
        ),
        OnboardingModel(
            title: "Рецепты буквально",
            description: "расписаны со всеми деталями",
            imageName: "Onboarding2"
        ),
        OnboardingModel(
            title: "Начни готовить прямо сейчас",
            description: "или сохрани до особого случая",
            imageName: "Onboarding3"
        )
    ]
    
    var isLastPage: Bool {
        currentPage == items.count - 1
    }
    
    func nextPage() {
        currentPage = min(currentPage + 1, items.count - 1)
    }
    
    func previousPage() {
        currentPage = max(currentPage - 1, 0)
    }
}
