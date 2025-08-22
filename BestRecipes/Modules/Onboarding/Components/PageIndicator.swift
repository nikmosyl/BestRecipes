//
//  PageIndicator.swift
//  BestRecipes
//
//  Created by nikita on 21.08.2025.
//

import SwiftUI

struct PageIndicator: View {
    @Binding var currentPage: Int
    let totalPages: Int
    let indicatorSize: CGFloat = 40
    let indicatorSpacing: CGFloat = 10
    
    var body: some View {
        HStack(spacing: indicatorSpacing) {
            ForEach((currentPage == 0 ? 1 : 0)..<totalPages, id: \.self) { page in
                RoundedRectangle(cornerRadius: indicatorSize / 10)
                    .fill(currentPage == page ?
                          LinearGradient(
                            gradient: Gradient(
                                stops: [
                                    Gradient.Stop(color: Color(hex: "#FA9BB1"), location: 0.0),
                                    Gradient.Stop(color: Color(hex: "#F8C89A"), location: 1.0)
                                ]
                            ),
                            startPoint: UnitPoint(x: 0.5, y: 0),
                            endPoint: UnitPoint(x: 0.5, y: 1)
                          ) :
                            LinearGradient(
                                gradient: Gradient(
                                    stops: [
                                        Gradient.Stop(color: Color(hex: "#D9D9D9"), location: 0.0)
                                    ]
                                ),
                                startPoint: UnitPoint(x: 0.5, y: 0),
                                endPoint: UnitPoint(x: 0.5, y: 1)
                            )
                    )
                    .frame(width: indicatorSize, height: 8)
                    .animation(.easeInOut(duration: 0.3), value: currentPage)
            }
        }
        .padding(.bottom, 8)
    }
}

#Preview {
    PageIndicator(currentPage: .constant(1), totalPages: 5)
}
