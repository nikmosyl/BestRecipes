//
//  TabItem.swift
//  BestRecipes
//
//  Created by Aleksandr Zhazhoyan on 12.08.2025.
//

import SwiftUI

enum TabItem: CaseIterable {
    case home
    case bookmark
    case add
    case notifications
    case profile
    
    var icon: String {
        switch self {
        case .home: return "Home"
        case .bookmark: return "Bookmark"
        case .add: return "plus"
        case .notifications: return "Notific"
        case .profile: return "Profile"
        }
    }
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .home:
            HomeView()
        case .bookmark:
            BookmarkView()
        case .add:
            AddView()
        case .notifications:
            NotificationsView()
        case .profile:
            ProfileView()
        }
    }
}
