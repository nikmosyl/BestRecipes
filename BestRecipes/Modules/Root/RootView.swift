//
//  RootView.swift
//  BestRecipes
//
//  Created by nikita on 18.08.2025.
//

import SwiftUI

struct RootView: View {
    @StateObject private var viewModel = RootViewModel()
    
    var body: some View {
//        if viewModel.isOnboardingComplete {
//            TabBarView()
//        } else {
            OnboardingView()
//        }
    }
}

#Preview {
    RootView()
}
