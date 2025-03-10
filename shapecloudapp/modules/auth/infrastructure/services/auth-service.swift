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
        
        print("reading data: ", String(data:data,encoding: .utf8) ?? "Nothing")
        let responseDto : ResponseDto<LoginResponseDto> = try JSONDecoder().decode(ResponseDto<LoginResponseDto>.self, from: data)
        
        guard (200..<300).contains(httpResponse?.statusCode ?? 500) else {
            throw NSError(domain:responseDto.error?.name ?? "AuthService", code: -1, userInfo: [NSLocalizedDescriptionKey:responseDto.error?.message ?? "Invalid response"])
        }
        
        guard responseDto.success else{
            throw NSError(domain:responseDto.error?.name ?? "AuthService", code: responseDto.statusCode, userInfo: [NSLocalizedDescriptionKey : responseDto.error?.message ?? "Unexpected Error"])
        }
        
        print(responseDto.data?.token ?? "")
        TokenManager.saveToken(responseDto.data?.token ?? "")
        
        return responseDto
    }
}
