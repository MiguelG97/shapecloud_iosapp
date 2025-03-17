//
//  SFolderBreadCumber.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 23/02/25.
//

import SwiftUI

struct SFolderBreadCumber: View {
    @Binding var selectedFolder : TreeViewBaseItem
    var folderStructure:[TreeViewBaseItem]
    
    private var folderPath: [(id: String, label: String)] {
            ProjectAppUtil.Shared.GetFolderPath(folderStructure: folderStructure, currentFolderId: selectedFolder.id).path
        }
    
    init(selectedFolder:Binding<TreeViewBaseItem>,folderStructure:[TreeViewBaseItem]){
        _selectedFolder = selectedFolder
        self.folderStructure = folderStructure
    }
    
    var body: some View {
        ScrollView(.horizontal){
            HStack {
                ForEach(folderPath.indices,id: \.self) { index in
                    let path = folderPath[index]
                    Text(path.label)
                        .foregroundStyle(index == folderPath.count - 1 ? Color.theme.foreground : Color.theme.foreground_muted)
                        .fontWeight(index == folderPath.count - 1 ? .medium : .regular)
                        .onTapGesture {
                            handleFolderSelection(folderId: path.id)
                        }
                    
                    if folderPath.count > 0 , index < folderPath.count-1 {
                        Image(systemName: "chevron.right")
                            .fontWeight(.medium)
                    }
                }
            }
        }
        .scrollBounceBehavior(.basedOnSize)
        .frame(maxWidth: .infinity,alignment: .leading)
        .background {
            Color.white
        }
    }
    private func handleFolderSelection(folderId: String) {
        let folderResult = ProjectAppUtil.Shared.GetFolderPath(folderStructure: folderStructure, currentFolderId: folderId)
        if folderResult.folderFound != nil {
            selectedFolder = folderResult.folderFound!
        }
        else{
            //do nothing meanwhile, do not change the folder. Ideally we should show a custom snackbar
        }
    }
    
}

#Preview {
    SFolderBreadCumber(selectedFolder: .constant(TreeViewBaseItem(id: "1", label: "Structure", children: [])),folderStructure: [defaultFolder])
}
