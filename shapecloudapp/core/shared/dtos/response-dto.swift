//
//  dto-response.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 4/03/25.
//

struct ResponseDto<T:Codable>:Codable {
    var data : T
    var success: Bool
    var error: ErrorResponse?
    var statusCode: Int
}

struct ErrorResponse: Codable {
    var name : String?
    var message : String?
}
