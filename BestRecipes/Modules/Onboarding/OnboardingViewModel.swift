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
            description: "Find best recipes for cooking",
            imageName: "Onboarding"
        ),
        OnboardingModel(
            title: "Recipes from all over the World",
            description: "over the World",
            imageName: "Onboarding1"
        ),
        OnboardingModel(
            title: "Recipes with",
            description: "each and every detail",
            imageName: "Onboarding2"
        ),
        OnboardingModel(
            title: "Cook it now or save it for later",
            description: "save it for later",
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
