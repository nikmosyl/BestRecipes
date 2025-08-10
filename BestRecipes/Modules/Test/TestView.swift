//
//  TestView.swift
//  BestRecipes
//
//  Created by nikita on 10.08.2025.
//

import SwiftUI

struct TestView: View {
    @StateObject private var viewModel = TestViewModel()
    
    var body: some View {
        Button {
            viewModel.increment()
        } label: {
            Text("Counter: \(viewModel.counter)")
                .foregroundStyle(.background)
                .padding()
                .background(Color.secondary)
        }
    }
}

#Preview {
    TestView()
}
