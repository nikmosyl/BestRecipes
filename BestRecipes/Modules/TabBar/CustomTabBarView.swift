//
//  CustomTabBarView.swift
//  BestRecipes
//
//  Created by Aleksandr Zhazhoyan on 12.08.2025.
//

import SwiftUI

struct CustomTabBarView: View {
    @ObservedObject var viewModel: TabBarViewModel

    private let barHeight: CGFloat = 106
    private let buttonSize: CGFloat = 48
    private let curveBottomSvgY: CGFloat = 50
    private let svgH: CGFloat = 115

    private let gap: CGFloat = 5
    private let edgePadding: CGFloat = 20

    var body: some View {
        let sy = barHeight / svgH
        let desiredButtonBottomY = curveBottomSvgY * sy - gap
        let offsetY = desiredButtonBottomY - buttonSize/2 - barHeight/2

        ZStack {
            VStack {
                Spacer()
                ZStack {
                    SvgTabBarShape()
                        .fill(.white)
                        .frame(height: barHeight)
                        .overlay(
                            SvgTabBarShape()
                                .stroke(.black.opacity(0.01), lineWidth: 0.1)
                        )
                        .shadow(color: .black.opacity(0.05), radius: 4, y: -2)
                    
                    HStack {
                        HStack(spacing: 50) {
                            tabButton(.home)
                                .padding(.leading, edgePadding)
                            tabButton(.bookmark)
                        }
                        
                        Spacer(minLength: buttonSize + 40)
                        
                        HStack(spacing: 50) {
                            tabButton(.notifications)
                            tabButton(.profile)
                                .padding(.trailing, edgePadding)
                        }
                    }
                    .padding(.horizontal, 28)

                    Button {
                        viewModel.select(tab: .add)
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(.black)
                            .frame(width: buttonSize, height: buttonSize)
                            .background(Color.red)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.16), radius: 5, y: 3)
                    }
                    .offset(y: offsetY)
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    private func tabButton(_ tab: TabItem) -> some View {
           Button {
               viewModel.selectedTab = tab
           } label: {
               Image(tab.icon)
                   .renderingMode(.template)
                   .font(.system(size: 25))
                   .foregroundColor(viewModel.selectedTab == tab ? .red : .gray)
           }
       }
}

#Preview {
    CustomTabBarView(viewModel: TabBarViewModel())
}
