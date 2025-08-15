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
    case plus
    case notifications
    case profile
    
    var icon: String {
        switch self {
        case .home: return "house"
        case .bookmark: return "bookmark"
        case .plus: return "plus"
        case .notifications: return "bell"
        case .profile: return "person"
        }
    }
}
