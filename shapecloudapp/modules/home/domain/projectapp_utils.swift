//
//  projectapp_utils.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 15/03/25.
//
struct FolderPathResult {
    var path : [(id: String, label: String)]
    var folderFound : TreeViewBaseItem?
}

class ProjectAppUtil {
    public static let Shared = ProjectAppUtil()
    private init(){}
    
    func GetFolderPath(folderStructure: [TreeViewBaseItem], currentFolderId:String) -> FolderPathResult {
        var path: [(id: String, label: String)] = []
        
        func findItem(_ items: [TreeViewBaseItem], parents: [(id: String, label: String)]) -> TreeViewBaseItem? {
            for item in items {
                let newParents = parents + [(id: item.id, label: item.label)]
                
                if item.id == currentFolderId {
                    path = path.count == 0 ? newParents : parents //Always return parent root folder if there is only 1 folder item
                    return item
                }
                
                if let children = item.children, let found = findItem(children, parents: newParents) {
                    return found
                }
            }
            return nil
        }
        
        let folderfound = findItem(folderStructure, parents: [])
        return FolderPathResult(path: path, folderFound: folderfound)
    }
}
