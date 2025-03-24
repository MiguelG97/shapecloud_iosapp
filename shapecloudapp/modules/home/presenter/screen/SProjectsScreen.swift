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
    @Binding var isBotTabBarHidden: Bool
    
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
                                Button{
                                    store.send(.pushNavigationPath(projectItem))
                                    store.send(.setCurrentProjectSelected(projectItem.name))
                                } label: {
                                    SProjectItem(project: projectItem)
                                        .foregroundStyle(Color.theme.foreground)
                                }
                                
                            }
                        }
                    }
                    
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
                .listRowInsets(EdgeInsets())
            }
            .buttonStyle(PlainButtonStyle())
            .listStyle(PlainListStyle())
            .listSectionSeparator(.hidden)
            .scrollIndicators(.hidden)
            .navigationDestination(for: Project.self) { project in
                SFoldersScreen(project:project,isBotTabBarHidden: $isBotTabBarHidden)
                .toolbar(.hidden)
            }
            .padding(.horizontal,SScreenSize.hPadding)
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
        }.onChange(of: store.navigationPath, { a, b in
            print("Navigation path changed:", b)
        })

    }
}

#Preview {
    SProjectsScreen(store:Store(initialState: ProjectsFeature.State(), reducer: {
        ProjectsFeature()
    }),isBotTabBarHidden: .constant(false))
        .environment(\.font, .custom(ThemeFonts.shared.geistRegular, size: 16))
        .environment(\.screenSize, CGSize(width: 402, height: 874))
        .environment(\.safeArea, EdgeInsets(top: 62, leading: 0, bottom: 34, trailing: 0))
}
