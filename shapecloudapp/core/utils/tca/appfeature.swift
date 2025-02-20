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
        var areBarsHidden : Bool = false
        
        var projects = ProjectsFeature.State()
    }
    
    enum Action{
        case setSelectedTab(STab)
        case setAreBarsHidden(Bool)
        
        case projects(ProjectsFeature.Action)
        case popNavigation
    }
    
    var body: some ReducerOf<Self>{
        
        //Scope reducer: It helps to compose the other features logic to not repeat that code again! (it runs a child reducer on this domain)
        Scope(state: \.projects, action: \.projects) {
            ProjectsFeature()
        }
        
        Reduce { state, action in
            switch action {
                case .setSelectedTab(let tab):
                    state.selectedTab = tab
                    return .none
                case .setAreBarsHidden(let hidden):
                    state.areBarsHidden = hidden
                    return .none
                case .projects(_):
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
