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
                        Button { viewModel.select(tab: .home) } label: {
                            Image(systemName: "house")
                                .font(.system(size: 24))
                                .frame(width: 32, height: 30)
                                .foregroundStyle(viewModel.selectedTab == .home ? .red : .gray)
                        }
                        Spacer()

                        Button { viewModel.select(tab: .bookmark) } label: {
                            Image(systemName: "bookmark")
                                .font(.system(size: 24))
                                .frame(width: 96, height: 30)
                                .foregroundStyle(viewModel.selectedTab == .bookmark ? .red : .gray)
                        }
                        
                        Spacer().frame(width: buttonSize + 24)

                        Button { viewModel.select(tab: .notifications) } label: {
                            Image(systemName: "bell")
                                .font(.system(size: 24))
                                .frame(width: 96, height: 30)
                                .foregroundStyle(viewModel.selectedTab == .notifications ? .red : .gray)
                        }
                        Spacer()

                        Button { viewModel.select(tab: .profile) } label: {
                            Image(systemName: "person")
                                .font(.system(size: 24))
                                .frame(width: 32, height: 30)
                                .foregroundStyle(viewModel.selectedTab == .profile ? .red : .gray)
                        }
                    }
                    .padding(.horizontal, 28)
                    
                    Button { viewModel.centralAction() } label: {
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
    }
}

#Preview {
    CustomTabBarView(viewModel: TabBarViewModel())
}
