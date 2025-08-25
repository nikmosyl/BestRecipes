//
//  RootView.swift
//  BestRecipes
//
//  Created by Aleksandr Zhazhoyan on 15.08.2025.
//

import SwiftUI

struct TabBarView: View {
    @StateObject private var viewModel = TabBarViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                viewModel.selectedTab.view
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .safeAreaInset(edge: .bottom) {
                        Color.clear.frame(height: 70)
                    }
                
                CustomTabBarView(viewModel: viewModel)
            }
            .navigationDestination(isPresented: $viewModel.showAddView) {
                CreateRecipeView()
            }
        }
    }
}


// MARK: - Примеры экранов
struct NotificationsView: View {
    var body: some View {
        VStack {
            Text("🔔 Уведомления")
                .font(.largeTitle)
        }
    }
}

#Preview {
    TabBarView()
}
