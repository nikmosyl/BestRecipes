//
//  RootViewModel.swift
//  BestRecipes
//
//  Created by nikita on 18.08.2025.
//

import Foundation

final class RootViewModel: ObservableObject {
    @Published var isOnboardingComplete = DataManager.shared.isOnboardingComplete()
}
