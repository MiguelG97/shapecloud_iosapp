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
         
        ZStack(alignment:.bottom) {
            VStack {
                //conditionally remove it when navPath has at least 1 item
                Spacer()
                    .frame(maxWidth: .infinity,maxHeight: safeArea.top*0.8 + 50)
                
                switch selectedTab {
                case .projects:
                    SProjectsScreen(areBarsHidden: $areBarsHidden)
                case .search:
                    Text("2")
                case .support:
                    Text("3")
                case .profile:
                    Text("4")
                }
                
            }
            .padding(.bottom,20)
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
            .overlay(alignment: .top) {
                //??conditionally remove it when navPath has at least 1 item
                SNavBarView(title:"SHAPECLOUD",icon: Image(systemName: "line.3.horizontal"),iconCallBack: {
                    
                })
                    .offset(y: safeArea.top*0.8)
                    .background {
                        Color.white
                    }
            }
            
            //conditionally remove it when ??
            SCustomTabBar(selectedTab: $selectedTab,isBarHidden: areBarsHidden)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    HomeScreen()
        .environment(\.font, .custom(ThemeFonts.shared.geistRegular, size: 16))
        .environment(\.screenSize, CGSize(width: 402, height: 874))
        .environment(\.safeArea, EdgeInsets(top: 62, leading: 0, bottom: 34, trailing: 0))
}
