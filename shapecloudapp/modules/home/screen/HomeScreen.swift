//
//  HomeScreen.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 9/02/25.
//

import SwiftUI


enum STab : Int{
    case projects
    case search
    case support
    case profile
    
}

struct HomeScreen: View {
    
    @Environment(\.screenSize) private var screenSize : CGSize
    @Environment(\.safeArea) private var safeArea : EdgeInsets
    
    @State private var selectedTab : STab = .projects
    @State private var areBarsHidden: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment:.bottom) {
                VStack {
                    Spacer()
                        .frame(maxWidth: .infinity,maxHeight: safeArea.top*0.8 + 50)
                    
                    if selectedTab == .projects{
                        SProjectsView(areBarsHidden: $areBarsHidden)
                    }
                    else if selectedTab == .search{
                        
                    }
                    else if selectedTab == .support{
                        
                    }
                    else if selectedTab == .profile{
                        
                    }
                    
                }
                .padding(.bottom,20)
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
                .overlay(alignment: .top) {
                    SNavBarView()
                        .offset(y: safeArea.top*0.8)
                        .background {
                            Color.white
                        }
                }
                
                SCustomTabBar(selectedTab: $selectedTab,isBarHidden: areBarsHidden)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    HomeScreen()
        .environment(\.font, .custom(ThemeFonts.shared.geistRegular, size: 16))
        .environment(\.screenSize, CGSize(width: 402, height: 874))
        .environment(\.safeArea, EdgeInsets(top: 62, leading: 0, bottom: 34, trailing: 0))
}
