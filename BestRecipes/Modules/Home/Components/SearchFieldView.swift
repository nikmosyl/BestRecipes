//
//  SearchFieldView.swift
//  BestRecipes
//
//  Created by Николай Игнатов on 18.08.2025.
//

import SwiftUI

struct SearchFieldView: View {
    @Binding var searchText: String
    let onReturn: () -> Void
    let closeAction: () -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: "magnifyingglass")
                .frame(width: 20, height: 20)
                .padding(16)
                .foregroundStyle(.gray)
            
            TextField("Search recipes", text: $searchText)
                .onSubmit {
                    onReturn()
                }
            
            if !searchText.isEmpty {
                Button {
                    closeAction()
                } label: {
                    Image(systemName: "xmark")
                        .padding(16)
                        .foregroundStyle(.gray)
                }
            }
        }
        
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(
                    searchText.isEmpty ? Color.gray : Color.red,
                    lineWidth: 1
                )
        }
        .padding(.top, 16)
    }
}

#Preview {
    SearchFieldView(
        searchText: .constant("Test text"),
        onReturn: {},
        closeAction: {}
    )
}
