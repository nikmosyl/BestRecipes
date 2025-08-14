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
                    VStack(spacing: 16) { // Вертикальное расположение кнопок
                        Button(action: {
                            if viewModel.isLastPage {
                                viewModel.completeOnboarding()
                                showOnboarding = false
                            } else {
                                viewModel.nextPage()
                            }
                        }) {
                            Text(determineButtonTitle(for: viewModel.currentPage, totalPages: viewModel.items.count))
                                .padding()
                                .frame(width: 156, height: 56, alignment: .center)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding()
                        
                        if viewModel.currentPage > 0 {
                            Button(action: {
                                viewModel.completeOnboarding()
                                showOnboarding = false
                            }) {
                                Text("Пропустить")
                                    .foregroundColor(Color.white)
                                    .font(.subheadline)
                            }
                            .padding()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 24)
                }
                .onAppear {
                    checkFirstLaunch()
                }
            } else {
                TestView()
            }
        }
        .ignoresSafeArea()
    }
    
    private func checkFirstLaunch() {
        let hasLaunchedBefore = UserDefaults.standard.bool(forKey: "hasLaunchedBefore")
        if hasLaunchedBefore {
            showOnboarding = true
        }
    }
    
    private func determineButtonTitle(for currentPage: Int, totalPages: Int) -> String {
           switch currentPage {
           case 0:
               return "Начать"
           case 1..<totalPages-1:
               return "Продолжить"
           default:
               return "Начать готовить"
           }
       }
   }

#Preview {
    OnboardingView()
}
