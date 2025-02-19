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
    struct State{
        var projects = ProjectsFeature.State()
        var selectedTab : STab = .projects
        var areBarsHidden : Bool = false
        var isNestedView : Bool = false
    }
    
    enum Action{
        case projects(ProjectsFeature.Action)
        case setSelectedTab(STab)
        case setAreBarsHidden(Bool)
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
            case .projects(.setNavigationPath(let path)):
                    state.isNestedView = path.count > 0
                    return .none
            case .projects(_):
                return .none
            }
        }
    }
}
