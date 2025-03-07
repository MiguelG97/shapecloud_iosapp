//
//  appreducer.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 17/02/25.
//

import ComposableArchitecture

@Reducer
struct AppFeature {
    //If we want views to update UI base on changes on this state, we need to observe it! (it's like a @state)
    @ObservableState
    struct State: Equatable{
        var selectedTab : STab = .projects
        var isBotTabBarHidden : Bool = false
        
        var projects = ProjectsFeature.State()
        var auth = AuthFeature.State()
    }
    
    enum Action{
        case setSelectedTab(STab)
        case setisBotTabBarHidden(Bool)
        
        case projects(ProjectsFeature.Action)
        case auth(AuthFeature.Action)
        case popNavigation
    }
    
    var body: some ReducerOf<Self>{
        
        //Scope reducer: It helps to compose the other features logic to not repeat that code again! (it runs a child reducer on this domain)
        Scope(state: \.projects, action: \.projects) {
            ProjectsFeature()
        }
        Scope(state: \.auth, action: \.auth) {
            AuthFeature()
        }
        
        Reduce { state, action in
            switch action {
                case .setSelectedTab(let tab):
                    state.selectedTab = tab
                    return .none
                case .setisBotTabBarHidden(let hidden):
                    state.isBotTabBarHidden = hidden
                    return .none
                case .projects(_):
                    return .none
                case .auth(_):
                    return .none
                case .popNavigation:
                    //depending on the selected tab I should send an asynchronous action
//                    switch state.selectedTab:
//                        case .projects:
//                            return .send(.projects(.popNavigation))
                    return .send(.projects(.popNavigation))
            }
        }
    }
}
