//
//  ProjectsFeature.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 18/02/25.
//

let defaultFolder = TreeViewBaseItem(id: "1", label: "root folder");


enum ProjectNavigationDestination: Hashable {
    case project(Project)
    case viewerModel(ViewerNavigationModel)
}

import ComposableArchitecture
@Reducer
struct ProjectsFeature{
    
    @ObservableState
    struct State: Equatable{
        var navigationPath : [ProjectNavigationDestination] = []
        var projects : [Project] = [
        ]
        var currentProjectSelected : String?
    }
    enum Action{
        case pushNavigationPath(ProjectNavigationDestination)
        case setNavigationPath([ProjectNavigationDestination])
        case setProjects([Project])
        case setCurrentProjectSelected(String?)
        case popNavigation
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case .pushNavigationPath(let newProjectDestination):
                    state.navigationPath.append(newProjectDestination)
                    return .none
                case .setNavigationPath(let projectDestination):
                    state.navigationPath = projectDestination
                    return .none
                case .setProjects(let projects):
                    state.projects = projects
                    return .none
                case .setCurrentProjectSelected(let projectName):
                    state.currentProjectSelected = projectName
                    return .none
                case .popNavigation:
                    if !state.navigationPath.isEmpty {
                        state.navigationPath.removeLast()
                    }
                    state.currentProjectSelected = nil
                    return .none
            }
        }
    }
}
