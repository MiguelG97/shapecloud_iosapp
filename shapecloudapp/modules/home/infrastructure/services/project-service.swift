//
//  project-service.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 9/03/25.
//
import Foundation
class ProjectService {
    public static let Shared : ProjectService = ProjectService()
    private init(){}
    
    func getProjects()async throws -> [Project] {
        
        guard let url = URL(string:"\(Config.getValue(for: "API_BASE_URL") ?? "" )/projects")
        else{
            throw NSError(domain: "URLerror", code: 101, userInfo: [NSLocalizedDescriptionKey : "Config value for API_BASE_URL not found"])
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
//        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im1ndXRpZXJyZXpAc2hhcGVjbG91ZC5jb20iLCJwYXNzd29yZCI6Im1pZ3VlbDEyMzQiLCJyb2xlIjoiMCIsImNvbXBhbnlJZCI6IjY3MzJjMzcyZDQxZWEwZWFkZDNiZDA1NyIsInVzZXJJZCI6IjY3MzJkOWU5MmRmNGM1Y2RiN2UyYzM4NSIsImlhdCI6MTc0MTU3NDUyMiwiZXhwIjoxNzQxNTg1MzIyfQ.k8MxmyHGJtPvhMHFtGI0z8tr2KT-DFpcYHSiEIG-7J"
        guard let token = TokenManager.getToken(), token != "" else {
            throw NSError(domain: "URLerror", code: 104, userInfo: [NSLocalizedDescriptionKey : "Token not found"])
        }
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let (data,response) = try await URLSession.shared.data(for: request)
        let httpResponse = response as? HTTPURLResponse
        
        print("reading data: ",String(data:data,encoding:.utf8) ?? "Nothing")
        let decoder = JSONDecoder()
//        decoder.dateDecodingStrategy = .iso8601// THIS IS BULLSHIT, DOESNT WORK!!
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            
            let iso8601WithMillisecondsFormatter = ISO8601DateFormatter()
            iso8601WithMillisecondsFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            if let date = iso8601WithMillisecondsFormatter.date(from: dateString) {
                return date
            }
            
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date format: \(dateString)")
        }
        
        let responseDto : ResponseDto<[Project]> = try decoder.decode(ResponseDto<[Project]>.self, from: data)
        
        guard (200..<300).contains(httpResponse?.statusCode ?? 500) else {
            print("guard else: ",responseDto.success)
            throw NSError(domain: responseDto.error?.name ?? "ProjectService", code: -1, userInfo: [NSLocalizedDescriptionKey: responseDto.error?.message ?? "Server Error"])
        }
        
        guard responseDto.success else {
            throw NSError(domain:responseDto.error?.name ?? "ProjectService", code: responseDto.statusCode, userInfo: [NSLocalizedDescriptionKey : responseDto.error?.message ?? "Unexpected Error"])
        }
        
        return responseDto.data ?? []
    }
}
