//
//  OnboardingView.swift
//  BestRecipes
//
//  Created by Rook on 12.08.2025.
//

import SwiftUI

struct PageIndicator: View {
    @Binding var currentPage: Int
    let totalPages: Int
    let indicatorSize: CGFloat = 40
    let indicatorSpacing: CGFloat = 10
    
    var body: some View {
        HStack(spacing: indicatorSpacing) {
            ForEach((currentPage == 0 ? 1 : 0)..<totalPages, id: \.self) { page in
                RoundedRectangle(cornerRadius: indicatorSize / 10)
                    .fill(currentPage == page ?
                        LinearGradient(
                            gradient: Gradient(
                                stops: [
                                    Gradient.Stop(color: Color(hex: "#FA9BB1"), location: 0.0),
                                    Gradient.Stop(color: Color(hex: "#F8C89A"), location: 1.0)
                                ]
                            ),
                            startPoint: UnitPoint(x: 0.5, y: 0),
                            endPoint: UnitPoint(x: 0.5, y: 1)
                        ) :
                        LinearGradient(
                            gradient: Gradient(
                                stops: [
                                    Gradient.Stop(color: Color(hex: "#D9D9D9"), location: 0.0)
                                ]
                            ),
                            startPoint: UnitPoint(x: 0.5, y: 0),
                            endPoint: UnitPoint(x: 0.5, y: 1)
                        )
                    )
                    .frame(width: indicatorSize, height: 8)
                    .animation(.easeInOut(duration: 0.3))
            }
        }
        .padding(.bottom, 8)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let intValue = Int(int)
        
        let r = Int(intValue >> 16 & 0xFF)
        let g = Int(intValue >> 8 & 0xFF)
        let b = Int(intValue & 0xFF)
        
        self.init(
            red: CGFloat(r) / 255,
            green: CGFloat(g) / 255,
            blue: CGFloat(b) / 255
        )
    }
}

// 2. Обновляем OnboardingView
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
                .tabViewStyle(PageTabViewStyle(indexDisplayMode:.never))
                .overlay(alignment: .bottom) {
                    VStack(spacing: 16) {
                        // Условное отображение индикатора
                        if viewModel.currentPage > 0 {
                            PageIndicator(currentPage: $viewModel.currentPage, totalPages: viewModel.items.count)
                        }
                        
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
