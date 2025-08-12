//
//  BestRecipesApp.swift
//  BestRecipes
//
//  Created by nikita on 10.08.2025.
//

import SwiftUI

@main
struct OnboardingApp: App {
    @State private var showOnboarding = true
    
    var body: some Scene {
        WindowGroup {
            if showOnboarding {
                OnboardingView()
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                        checkFirstLaunch()
                    }
            } else {
                TestView()
            }
        }
    }
    
    private func checkFirstLaunch() {
        let hasLaunchedBefore = UserDefaults.standard.bool(forKey: "hasLaunchedBefore")
        showOnboarding = !hasLaunchedBefore
    }
}
