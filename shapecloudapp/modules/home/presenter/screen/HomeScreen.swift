//
//  HomeScreen.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 9/02/25.
//

import SwiftUI
import ComposableArchitecture

enum STab : Int{
    case projects
    case search
    case support
    case profile
    
}

struct HomeScreen: View {
    //if we have components that require bindings, we can use @Bindable and the sending() command to pass an action for sending the values!!
    @Bindable var store: StoreOf<AppFeature>
    
    @Environment(\.screenSize) private var screenSize : CGSize
    @Environment(\.safeArea) private var safeArea : EdgeInsets
    
    @State private var areBarsHidden: Bool = false
    
    var body: some View {
         
        ZStack(alignment:.bottom) {
            VStack {
                WithViewStore(store, observe: \.projects) { projectsViewStore in
                    if projectsViewStore.navigationPath.count == 0{
                        Spacer()
                            .frame(maxWidth: .infinity,maxHeight: safeArea.top*0.8 + 50)
                    }
                }
                
                switch store.selectedTab {
                case .projects:
                    SProjectsScreen(store:store.scope(state: \.projects, action: \.projects),areBarsHidden: $store.areBarsHidden.sending(\.setAreBarsHidden))
                case .search:
                    VStack {
                        Color.red
                    }
                case .support:
                    VStack {
                        Color.green
                    }
                case .profile:
                    VStack {
                        Color.purple
                    }
                }
                
            }
            .padding(.bottom,20)
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
            .overlay(alignment: .top) {
                //??conditionally remove it when navPath has at least 1 item
                //apparently i might need to repeat this component on every tab view!
                SNavBarView(title:"SHAPECLOUD",icon: Image(systemName: store.isNestedView ? "chevron.backward":"line.3.horizontal"),iconCallBack: {
//                    store.send(.)
                })
                .offset(y: safeArea.top*0.8)
                .background {
                        Color.white
                    }
            }
            
            //conditionally remove it when ??
            SCustomTabBar(selectedTab: $store.selectedTab.sending(\.setSelectedTab),isBarHidden: store.areBarsHidden)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    HomeScreen(store:Sstore)
        .environment(\.font, .custom(ThemeFonts.shared.geistRegular, size: 16))
        .environment(\.screenSize, CGSize(width: 402, height: 874))
        .environment(\.safeArea, EdgeInsets(top: 62, leading: 0, bottom: 34, trailing: 0))
}
