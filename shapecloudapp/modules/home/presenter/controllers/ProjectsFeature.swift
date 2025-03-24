//
//  ProjectsFeature.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 18/02/25.
//

let defaultFolder = TreeViewBaseItem(id: "1", label: "root folder");

import ComposableArchitecture
@Reducer
struct ProjectsFeature{
    
    @ObservableState
    struct State: Equatable{
        var navigationPath : [Project] = []
        var projects : [Project] = [
//            Project(id: "1", name: "miguel", location: "Peru", createdOn: .now, folderStructure: [defaultFolder], companyId: "12314"),
//             Project(id: "3", name: "miguel", location: "Peru", createdOn: .now, folderStructure: [defaultFolder], companyId: "12314")
        ]
        var currentProjectSelected : String?
    }
    enum Action{
        case pushNavigationPath(Project)
        case setNavigationPath([Project])
        case setProjects([Project])
        case setCurrentProjectSelected(String?)
        case popNavigation
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case .pushNavigationPath(let newPath):
                    state.navigationPath.append(newPath)
                    return .none
                case .setNavigationPath(let navigationPath):
                    print("🔍 NavigationPath updated:", navigationPath) // Debug Log
                    state.navigationPath = navigationPath
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
