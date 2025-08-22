//
//  OnboardingView.swift
//  BestRecipes
//
//  Created by Rook on 12.08.2025.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    @StateObject var rootViewModel: RootViewModel
    
    var body: some View {
        ZStack {
            TabView(selection: $viewModel.currentPage) {
                ForEach(viewModel.items.indices, id: \.self) { index in
                    OnboardingPageView(item: viewModel.items[index])
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .overlay(alignment: .bottom) {
                VStack(spacing: 24) {
                    // Место для индикатора или кнопки
                    if viewModel.currentPage == 0 {
                        Spacer(minLength: 80) // Создаем пространство для кнопки
                    } else {
                        PageIndicator(
                            currentPage: $viewModel.currentPage,
                            totalPages: viewModel.items.count - 1
                        )
                        .padding(.bottom, 16)
                    }
                    
                    // Единственная кнопка навигации
                    Button(action: {
                        if viewModel.isLastPage {
                            rootViewModel.completeOnboarding()
                        } else {
                            viewModel.nextPage()
                        }
                    }) {
                        Text(determineButtonTitle(
                            for: viewModel.currentPage,
                            totalPages: viewModel.items.count
                        ))
                        .padding()
                        .frame(width: 156, height: 56)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    
                    // Кнопка "Пропустить"
                    if viewModel.currentPage > 0 {
                        Button(action: {
                            rootViewModel.completeOnboarding()
                        }) {
                            Text("Пропустить")
                                .foregroundColor(Color.white)
                                .font(.subheadline)
                        }
                        .padding(20)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 24)
                .padding(.vertical, 30)
            }
        }
        .ignoresSafeArea()
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
    OnboardingView(rootViewModel: RootViewModel())
}
