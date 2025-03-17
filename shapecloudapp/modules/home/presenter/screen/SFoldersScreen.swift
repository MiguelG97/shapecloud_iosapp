//
//  SFoldersScreen.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 16/02/25.
//

import SwiftUI
import SwiftUIIntrospect

struct SFoldersScreen: View {
    var project: Project
    
    @Binding var isBotTabBarHidden: Bool
    
    @State private var selectedFolder : TreeViewBaseItem
    
    init(project: Project, isBotTabBarHidden: Binding<Bool>) {
        self.project = project
        self._isBotTabBarHidden = isBotTabBarHidden
        
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
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.bottom,4)
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .background{Color.white}
                    }

                    Section {
                        ForEach(selectedFolder.files ?? [], id: \.self) { file in
                            SFileItem(file: file)
                        }
                    } header: {
                        Text("Files")
                            .font(.title2)
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
        .onAppear {
            withAnimation(.easeInOut(duration: 0.5)) {
                isBotTabBarHidden = true
            }
        }
        .onDisappear {
            withAnimation(.easeInOut(duration: 0.5)) {
                isBotTabBarHidden = false
            }
        }
        .buttonStyle(.plain)
        
    }
}

#Preview {
    SFoldersScreen(project: Project(id: "123", name: "Huascar 203", location: "Perú",folderStructure: [
        TreeViewBaseItem(id: "1", label: "MEP",children:[
            TreeViewBaseItem(id: "1-1", label: "Struc"),
            TreeViewBaseItem(id: "1-2", label: "Struc x2"),
        ]),
    ], companyId: "asdd1"),isBotTabBarHidden: .constant(false))
        .environment(\.font, .custom(ThemeFonts.shared.geistRegular, size: 16))
        .environment(\.screenSize, CGSize(width: 402, height: 874))
        .environment(\.safeArea, EdgeInsets(top: 62, leading: 0, bottom: 34, trailing: 0))
}
