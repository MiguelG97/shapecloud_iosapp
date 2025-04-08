//
//  SFoldersScreen.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 16/02/25.
//

import SwiftUI
import SwiftUIIntrospect
import ComposableArchitecture

struct SFoldersScreen: View {
    var store: StoreOf<ProjectsFeature>
    
    var project: Project
    
    @State private var selectedFolder : TreeViewBaseItem
    
    init(store: StoreOf<ProjectsFeature>, project: Project) {
        self.project = project
        self.store = store
        
        _selectedFolder = State(initialValue: project.folderStructure.first!)
    }
    
    var body: some View {
        
        VStack(spacing:12){
            //I dont like it here, maybe it should be within the folder section, not outside!
            SFolderBreadCumber(selectedFolder: $selectedFolder,folderStructure: project.folderStructure )
                
            ScrollView{
                LazyVStack(spacing:12,pinnedViews: .sectionHeaders){
                    
                    Section {
                        ScrollView(.horizontal) {
                            HStack(spacing:14) {
                                ForEach(selectedFolder.children ?? [], id: \.self) { folder in
                                    
                                    SFolderCard(folderItem: folder)
                                        .padding(.vertical,1)
                                        .onTapGesture {
                                            if selectedFolder.id != folder.id{
                                                selectedFolder = folder
                                            }
                                        }
                                }
                            }.padding(.leading,1)
                        }
                        .scrollIndicators(.hidden)
                    } header: {
                        Text("Folders")
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .padding(.bottom,4)
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .background{Color.white}
                    }

                    Section {
                        ForEach(selectedFolder.files ?? [], id: \.self) { file in
                            SFileItem(file: file)
                                .onTapGesture {
                                    if file.isViewable == true {
                                        store.send(.pushNavigationPath(.viewerModel(ViewerNavigationModel(projectId: project._id, modelId: file.id))))
                                    }
                                }
                        }
                    } header: {
                        Text("Files")
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .padding(.bottom,4)
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .background{Color.white}
                    }
                }
            }
        }
        .padding(.top,12)
        .padding(.horizontal, SScreenSize.hPadding)
        .buttonStyle(.plain)
        .background {
            Color.white
        }
        .foregroundStyle(Color.theme.foreground)
        .ignoresSafeArea()
    }
}

#Preview {
    SFoldersScreen(store: Store(initialState: ProjectsFeature.State(), reducer: {
        ProjectsFeature()
    }), project: Project(id: "123", name: "Huascar 203", location: "Perú",folderStructure: [
        TreeViewBaseItem(id: "1", label: "MEP",children:[
            TreeViewBaseItem(id: "1-1", label: "Struc"),
            TreeViewBaseItem(id: "1-2", label: "Struc x2"),
        ]),
    ], companyId: "asdd1"))
        .environment(\.font, .custom(ThemeFonts.shared.geistRegular, size: 16))
        .environment(\.screenSize, CGSize(width: 402, height: 874))
        .environment(\.safeArea, EdgeInsets(top: 62, leading: 0, bottom: 34, trailing: 0))
}
