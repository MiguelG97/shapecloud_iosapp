//
//  SProjectsScreen.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 14/02/25.
//

import SwiftUI
import ComposableArchitecture
import SwiftUIIntrospect

struct SProjectsScreen: View {
    @Bindable var store: StoreOf<ProjectsFeature>
    
    @State private var searchText: String = ""
    
    @Environment(\.safeArea) private var safeArea: EdgeInsets
    @Environment(\.screenSize) private var screenSize: CGSize
    @Environment(\.dismiss) var dismiss
    
    private var isLoading : Bool {
        store.projects.isEmpty
    }
    
    var body: some View {
        NavigationStack(path:$store.navigationPath.sending(\.setNavigationPath)) {
            List{
                Section {
                    VStack(spacing:16) {
                        if isLoading  {
                            ForEach(0..<5,id:\.self) { _ in
                                ProjectItemSkeleton()
                            }
                        }
                        else{
                            ForEach(store.projects,id:\._id) { projectItem in
                                if projectItem.name.range(of: searchText, options: [.caseInsensitive, .diacriticInsensitive]) != nil || searchText == "" {
                                    Button{
                                        store.send(.pushNavigationPath(.project(projectItem)))
                                        store.send(.setCurrentProjectSelected(projectItem.name))
                                    } label: {
                                        SProjectItem(project: projectItem)
                                            .foregroundStyle(Color.theme.foreground)
                                    }
                                }
                                
                                
                            }
                        }
                    }
                    .background {
                        Color.white
                    }
                    .listRowInsets(EdgeInsets())
                } header: {
                    VStack(spacing:16) {
                        HStack {
                            Text("Your")
                            Text("Projects")
                                .fontWeight(.bold)
                            Text("Are Here!")
                            
                        }
                        .foregroundStyle(.black)
                        .font(.title)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.horizontal,12)
                        .padding(.vertical,0)
                        
                        HStack {
                            SSearchField(searchValue: $searchText)
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "slider.horizontal.3")
                                    .foregroundStyle(.white)
                                    .fontWeight(.medium)
                                    .font(.system(size: 24))
                                    .frame(width:50.66,height: 50.66)
                                    .background {
                                        Circle().fill(Color.theme.primary)
                                    }
                            }
                        }
                    }
                    .padding(.top,8)
                    .padding(.bottom,16)
                    .background(.white)
                }
                .background{
                    Color.white
                }
                .listRowInsets(EdgeInsets())
            }
            .scrollContentBackground(.hidden)
            .padding(.horizontal,SScreenSize.hPadding)
            .background(Color.white)
            .buttonStyle(PlainButtonStyle())
            .listStyle(PlainListStyle())
            .listRowInsets(EdgeInsets())
            .listSectionSeparator(.hidden)
            .scrollIndicators(.hidden)
            .navigationDestination(for: ProjectNavigationDestination.self) { destination in
                
                switch destination{
                    case .project(let project):
                    SFoldersScreen(store: store, project:project)
                        .toolbar(.hidden)
                    case .viewerModel(let viewerModel):
                        SViewerScreen(projectId: viewerModel.projectId, modelId: viewerModel.modelId)
                        .toolbar(.hidden)
                }
                
            }
            .ignoresSafeArea()
            .onAppear {
                Task {
                    if isLoading{
                        do {
                            let projectsData = try await ProjectService.Shared.getProjects()
                            store.send(.setProjects(projectsData))
                        }
                        catch{
                            print("error found: ",error.localizedDescription)
                        }
                    }
                    
                }
            }
            .refreshable {
                do {
                    let projectsData = try await ProjectService.Shared.getProjects()
                    store.send(.setProjects(projectsData))
                }
                catch{
                    print("error found: ",error.localizedDescription)
                }
            }
        }
    }
}


#Preview {
    SProjectsScreen(store:Store(initialState: ProjectsFeature.State(), reducer: {
        ProjectsFeature()
    }))
        .environment(\.font, .custom(ThemeFonts.shared.geistRegular, size: 16))
        .environment(\.screenSize, CGSize(width: 440, height: 874))
        .environment(\.safeArea, EdgeInsets(top: 62, leading: 0, bottom: 34, trailing: 0))
}
