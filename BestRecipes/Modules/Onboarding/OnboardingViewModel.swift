//
//  OnboardingViewModel.swift
//  BestRecipes
//
//  Created by Rook on 12.08.2025.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    
    var body: some View {
        ZStack {
            TabView(selection: $viewModel.currentPage) {
                ForEach(viewModel.items) { item in
                    OnboardingPageView(item: item)
                        .tag(item.id)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            
            VStack {
                Spacer()
                
                if viewModel.isLastPage {
                    Button(action: {
                        viewModel.completeOnboarding()
                        // Логика перехода к основному экрану
                    }) {
                        Text("Начать")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            checkFirstLaunch()
        }
    }
    
    private func checkFirstLaunch() {
        let hasLaunchedBefore = UserDefaults.standard.bool(forKey: "hasLaunchedBefore")
        if hasLaunchedBefore {
            // Переход к основному экрану
        }
    }
}
