//
//  BestRecipesApp.swift
//  BestRecipes
//
//  Created by nikita on 10.08.2025.
//

import SwiftUI

@main
struct MyApp: App {
    @State private var showOnboarding = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if showOnboarding {
                    OnboardingView()
                        .onAppear {
                            checkFirstLaunch()
                        }
                } else {
                    TestView()
                }
            }
        }
    }
    
    private func checkFirstLaunch() {
        let hasLaunchedBefore = UserDefaults.standard.bool(forKey: "hasLaunchedBefore")
        showOnboarding = !hasLaunchedBefore
    }
}
