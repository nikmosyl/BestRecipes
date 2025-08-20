//
//  TabBarViewModel.swift
//  BestRecipes
//
//  Created by Aleksandr Zhazhoyan on 12.08.2025.
//

import Foundation

final class TabBarViewModel: ObservableObject {
    @Published var selectedTab: TabItem = .home
    @Published var showAddView: Bool = false
    
    func select(tab: TabItem) {
        selectedTab = tab
    }
}
