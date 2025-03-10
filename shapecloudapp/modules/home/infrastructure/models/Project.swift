//
//  Project.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 16/02/25.
//
import Foundation

struct Project:Hashable, Codable, Equatable {
    var name: String
    var location: String
    var folderStructure: [TreeViewBaseItem]?
    var createdOn: Date?
    var companyId: String
    
    init(name: String, location: String, createdOn: Date? = nil, folderStructure: [TreeViewBaseItem]? = nil, companyId: String) {
        self.name = name
        self.location = location
        self.createdOn = createdOn ?? Date().addingTimeInterval(7 * 24 * 60 * 60) // default to 7 days later
        self.folderStructure = folderStructure
        self.companyId = companyId
    }
    
    enum CodingKeys: String, CodingKey {
        case name, location, folderStructure, createdOn, companyId
    }
    
    static func == (lhs: Project, rhs: Project) -> Bool {
        return lhs.name == rhs.name &&
               lhs.location == rhs.location &&
               lhs.companyId == rhs.companyId &&
               lhs.createdOn == rhs.createdOn
    }
    func hash(into hasher: inout Hasher) {
            hasher.combine(name)
            hasher.combine(location)
            hasher.combine(companyId)
            hasher.combine(createdOn)
    }
}
