//
//  TreeViewBaseItem.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 16/02/25.
//

struct TreeViewBaseItem: Codable,Hashable,Equatable {
    var id: String
    var label: String
    var children: [TreeViewBaseItem]?
    var editable: Bool?
    var files: [TreeFile]?
    
    init(id: String, label: String, children: [TreeViewBaseItem]? = nil, editable: Bool? = nil, files: [TreeFile]? = nil) {
        self.id = id
        self.label = label
        self.children = children
        self.editable = editable
        self.files = files
    }
}
