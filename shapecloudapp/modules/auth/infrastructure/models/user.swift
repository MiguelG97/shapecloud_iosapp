//
//  user.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 4/03/25.
//

enum USER_ROLES: String, Codable {
  case user = "0"
  case admin = "1"
}

struct User: Codable, Equatable {
    var _id : String
    var name : String
    var email : String
    var role : USER_ROLES
    var companyId: String
    
    enum CodingKeys: String, CodingKey {
        case _id, name, email, role, companyId
    }
}
