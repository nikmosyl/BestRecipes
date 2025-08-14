//
//  OnboardingView.swift
//  BestRecipes
//
//  Created by Rook on 12.08.2025.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    @State private var showOnboarding = true
    
    var body: some View {
        ZStack {
            if showOnboarding {
                TabView(selection: $viewModel.currentPage) {
                    ForEach(viewModel.items.indices, id: \.self) { index in
                        OnboardingPageView(item: viewModel.items[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode:.always))
                .overlay(alignment: .bottom) {
                    HStack {
                        
                        
                        Spacer()
                        
                        Button(action: {
                            if viewModel.isLastPage {
                                viewModel.completeOnboarding()
                                showOnboarding = false
                            } else {
                                viewModel.nextPage()
                            }
                        }) {
                            Text(viewModel.isLastPage ? "Начать" : "Далее")
                                .padding()
                                .frame(width: 156, height: 56
                                       , alignment: .center)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                            
                        }
                        .padding()
                    }
                }
                .onAppear {
                    checkFirstLaunch()
                }
            } else {
                TestView()
            }
        }.ignoresSafeArea()
    }
    
    private func checkFirstLaunch() {
        let hasLaunchedBefore = UserDefaults.standard.bool(forKey: "hasLaunchedBefore")
        if hasLaunchedBefore {
            showOnboarding = true
        }
    }
}

#Preview {
    OnboardingView()
}
