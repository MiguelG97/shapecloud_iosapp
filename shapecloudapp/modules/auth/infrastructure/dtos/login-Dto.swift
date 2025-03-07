//
//  login-Dto.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 3/03/25.
//

struct LoginDto:Codable {
    var email: String;
    var password: String;
    var role: USER_ROLES
}

struct LoginResponseDto: Codable {
    let token: String
    let user: User
}
