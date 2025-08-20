//
//  BookmarkButton.swift
//  BestRecipes
//
//  Created by Mikhail Ustyantsev on 11.08.2025.
//

import SwiftUI

struct BookmarkButton: View {
    @Binding var isBookmarked: Bool
    var action: () -> Void
    var body: some View {
        Button {
            action()
            print("BookmarkButton: action()")
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
    @State var isBookmarked = false
    
    BookmarkButton(
        isBookmarked: $isBookmarked) {
            isBookmarked.toggle()
        }
}
