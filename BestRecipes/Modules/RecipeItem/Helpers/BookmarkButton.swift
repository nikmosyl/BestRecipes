//
//  BookmarkButton.swift
//  BestRecipes
//
//  Created by Mikhail Ustyantsev on 11.08.2025.
//

import SwiftUI

struct BookmarkButton: View {
    var action: () -> Void
    var isBookmarked: Bool
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Circle()
                    .foregroundStyle(.white)
                Image(isBookmarked ? "BookmarkActive" : "BookmarkInactive")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 18)
            }
            .frame(width: 32, height: 32)
        }
    }
}

#Preview {
    BookmarkButton(action: {
        print("--> bookmark button tapped")
    }, isBookmarked: true)
}
