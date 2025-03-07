//
//  auth_service.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 3/03/25.
//
import Foundation

class AuthService {
    public static let shared: AuthService = AuthService()
    private init(){}
    
    func Login(loginDto: LoginDto) async throws -> ResponseDto<LoginResponseDto> {
        guard let url = URL(string: "\(Config.getValue(for: "API_BASE_URL") ?? "")/auth/mobile") else {
            throw NSError(domain: "URLerror", code: 101, userInfo: [NSLocalizedDescriptionKey : "Config value for API_BASE_URL not found"])}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(loginDto)
        
        let (data,response) = try await URLSession.shared.data(for: request)
        let httpResponse = response as? HTTPURLResponse
        
        guard (200..<300).contains(httpResponse?.statusCode ?? 500) else {
            throw NSError(domain: "AuthService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])
        }
        
//        print("reading data: ", String(data:data,encoding: .utf8) ?? "Nothing")
        
        let respondeDto : ResponseDto<LoginResponseDto> = try JSONDecoder().decode(ResponseDto<LoginResponseDto>.self, from: data)
        
        guard respondeDto.success else{
            throw NSError(domain: "AuthService", code: respondeDto.statusCode, userInfo: [NSLocalizedDescriptionKey : respondeDto.error?.message ?? "Unexpected Error"])
        }
        
        TokenManager.saveToken(respondeDto.data.token)
        
        return respondeDto
    }
}
