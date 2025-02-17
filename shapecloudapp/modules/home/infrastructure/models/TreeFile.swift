//
//  TreeFile.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 16/02/25.
//
import Foundation

enum ExtensionNameFiles: String, Codable {
    case folder
    case rvt
    case pdf
    
    case dwg
    case dxf
    case nwd
}

struct TreeFile: Codable {
    var id: String
   var name: String
    var size: Double? // Size in MB
   var modifiedOn: Date?
   var extName: ExtensionNameFiles
   var link: String?
   var urn: String?
   var isViewable: Bool? = false
    init(id: String, name: String, extName: ExtensionNameFiles, size: Double? = nil, modifiedOn: Date? = nil, link: String? = nil, urn: String? = nil, isViewable: Bool? = false) {
            self.id = id
            self.name = name
            self.extName = extName
            self.size = size
            self.modifiedOn = modifiedOn
            self.link = link
            self.urn = urn
            self.isViewable = isViewable
        }
}
