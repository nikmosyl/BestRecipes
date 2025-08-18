//
//  SearchFieldView.swift
//  BestRecipes
//
//  Created by Николай Игнатов on 18.08.2025.
//

import SwiftUI

struct SearchFieldView: View {
    @Binding var searchText: String
    let closeAction: () -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            Image(.search)
                .frame(width: 20, height: 20)
                .padding(16)
            
            TextField("Search recipes", text: $searchText)
            
            if !searchText.isEmpty {
                Button {
                    closeAction()
                } label: {
                    Image(.xmark)
                        .padding(16)
                }
            }
        }
        
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.red, lineWidth: 1)
        }
    }
}

#Preview {
    SearchFieldView(searchText: .constant("Search recipes")) {}
}
