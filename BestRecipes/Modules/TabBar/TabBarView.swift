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
                    .background(Color(.systemGroupedBackground))
                    .ignoresSafeArea(edges: .bottom) // Только bottom, чтобы контент не заезжал под status bar
                
                CustomTabBarView(viewModel: viewModel)
            }
            .navigationDestination(isPresented: $viewModel.showAddView) {
                CreateRecipeView()
            }
        }
    }
}


// MARK: - Примеры экранов
struct HomeView: View {
    var body: some View {
        VStack {
            Text("🏠 Главная")
                .font(.largeTitle)
        }
    }
}

struct BookmarkView: View {
    var body: some View {
        VStack {
            Text("🔖 Закладки")
                .font(.largeTitle)
        }
    }
}

struct NotificationsView: View {
    var body: some View {
        VStack {
            Text("🔔 Уведомления")
                .font(.largeTitle)
        }
    }
}
