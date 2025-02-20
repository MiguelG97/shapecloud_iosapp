//
//  ProjectsFeature.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 18/02/25.
//
import ComposableArchitecture
@Reducer
struct ProjectsFeature{
    
    @ObservableState
    struct State: Equatable{
        var navigationPath : [Project] = []
        var projectItems : [Project] = [
            Project(name: "Project 1", location: "Description 1",companyId: "1"),
               Project(name: "Project 2", location: "Description 2",companyId: "2"),
               Project(name: "Project 3", location: "Description 3",companyId: "3"),
               Project(name: "Project 4", location: "Description 4",companyId: "4"),
               Project(name: "Project 5", location: "Description 5",companyId: "5"),
            Project(name: "Project 6", location: "Description 6",companyId: "6"),
        ]
    }
    enum Action{
        case setNavigationPath([Project])
        case setProjectItems([Project])
        case popNavigation
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case .setNavigationPath(let navigationPath):
                    state.navigationPath = navigationPath
                    return .none
                case .setProjectItems(let projectItems):
                    state.projectItems = projectItems
                    return .none
                case .popNavigation:
                    if !state.navigationPath.isEmpty {
                        state.navigationPath.removeLast()
                    }
                    return .none
            }
        }
    }
}
