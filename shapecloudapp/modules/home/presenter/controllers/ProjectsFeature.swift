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
//            Project(name: "Huascar 203", location: "Perú",folderStructure: [
//                TreeViewBaseItem(id: "1", label: "MEP",children: [
//                    TreeViewBaseItem(id: "1-1", label: "Rvt models", children: [], files: [TreeFile(id: "UNIDAA123", name: "Asia Boulevard", extName: .rvt)]),
//                    TreeViewBaseItem(id: "1-2", label: "Nws models", children: [], files: [TreeFile(id: "Rvt245", name: "Asia Navis", extName: .nwd)])
//                ],files: [TreeFile(id: "some", name: "Harass 123", extName: .rvt)])
//            ], companyId: "asdd1"),
//            Project(name: "Project 2", location: "Description 2",folderStructure: [defaultFolder],companyId: "2"),
//               Project(name: "Project 3", location: "Description 3",folderStructure: [defaultFolder],companyId: "3"),
//               Project(name: "Project 4", location: "Description 4",folderStructure: [defaultFolder],companyId: "4"),
//               Project(name: "Project 5", location: "Description 5",folderStructure: [defaultFolder],companyId: "5"),
//            Project(name: "Project 6", location: "Description 6",folderStructure: [defaultFolder],companyId: "6"),
        ]
    }
    enum Action{
        case setNavigationPath([Project])
        case setProjects([Project])
        case popNavigation
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case .setNavigationPath(let navigationPath):
                    state.navigationPath = navigationPath
                    return .none
                case .setProjects(let projects):
                    state.projects = projects
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
