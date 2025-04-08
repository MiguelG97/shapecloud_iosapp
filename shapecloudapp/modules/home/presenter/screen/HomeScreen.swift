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
    
    private var isNestedView: Bool {
        switch store.selectedTab {
        case .projects:
            return store.projects.navigationPath.count > 0
        case .profile:
            return false
        case .search:
            return false
        case .support:
            return false
        }
    }
    private var barStatus: BottomBarStatus {
        switch store.selectedTab{
            case .projects:
                let viewerModelExist = store.projects.navigationPath.contains(where: {
                    if case .viewerModel(_) = $0 {
                        return true
                    }
                    else {return false}
                });
                if viewerModelExist {
                    return .hidden
                }
                else {
                    return store.projects.navigationPath.count > 0 ? .semiVisible :.visible
                }
            case .profile:
                return .visible
            case .search:
                return .visible
            case .support:
                return .visible
        }
    }
    private var appBarTitle : String {
        store.projects.currentProjectSelected ?? "CevicheCloud"
    }
    
    var body: some View {
         
        ZStack(alignment:.bottom) {
            VStack {
                switch store.selectedTab {
                    case .projects:
                        Spacer()
                            .frame(maxWidth: .infinity,maxHeight: safeArea.top*0.8 + 50)
                        SProjectsScreen(store:store.scope(state: \.projects, action: \.projects))
                        
                    case .search:
                        VStack {
                            Text("...in development")
                                .foregroundStyle(Color.theme.foreground)
                        }
                        .frame(maxWidth: .infinity,maxHeight: .infinity)
                        .background {
                            Color.white
                        }
                    case .support:
                        VStack {
                            Text("...in development")
                                .foregroundStyle(Color.theme.foreground)
                        }
                        .frame(maxWidth: .infinity,maxHeight: .infinity)
                        .background {
                            Color.white
                        }
                    case .profile:
                        VStack {
                            Text("...in development")
                                .foregroundStyle(Color.theme.foreground)
                        }
                        .frame(maxWidth: .infinity,maxHeight: .infinity)
                        .background {
                            Color.white
                        }
                }
                
            }
            .padding(.bottom,20)
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
            .overlay(alignment: .top) {
                SAppBarView(title:appBarTitle,icon: Image(systemName: isNestedView ? "chevron.backward":"line.3.horizontal"),iconCallBack: {
                    store.send(.popNavigation)
                })
                .offset(y: safeArea.top*0.8)
                .background {
                    Color.white
                }
            }
            
            SBottomTabBar(selectedTab: $store.selectedTab.sending(\.setSelectedTab), barStatus: barStatus)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    HomeScreen(store:Sstore)
        .environment(\.font, .custom(ThemeFonts.shared.geistRegular, size: 16))
        .environment(\.screenSize, CGSize(width: 440, height: 874))
        .environment(\.safeArea, EdgeInsets(top: 62, leading: 0, bottom: 34, trailing: 0))
}
