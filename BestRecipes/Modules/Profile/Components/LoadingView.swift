//
//  LoadingView.swift
//  BestRecipes
//
//  Created by Aleksandr Meshchenko on 14.08.25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        HStack {
            Spacer()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
            Spacer()
        }
        .frame(minHeight: 200)
    }
}
