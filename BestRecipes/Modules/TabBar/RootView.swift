//
//  RootView.swift
//  BestRecipes
//
//  Created by Aleksandr Zhazhoyan on 15.08.2025.
//

import SwiftUI

struct RootView: View {
    @StateObject private var viewModel = TabBarViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            viewModel.selectedTab.view
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.systemGroupedBackground))
                .ignoresSafeArea()
            
            CustomTabBarView(viewModel: viewModel)
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

struct ProfileView: View {
    var body: some View {
        VStack {
            Text("👤 Профиль")
                .font(.largeTitle)
        }
    }
}

struct AddView: View {
    var body: some View {
        VStack {
            Text("➕ Добавление рецепта")
                .font(.largeTitle)
        }
    }
}
