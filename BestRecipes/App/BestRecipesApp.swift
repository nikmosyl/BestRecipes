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
                OnboardingView()
            }
        }
    }
}
