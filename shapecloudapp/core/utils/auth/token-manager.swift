//
//  token-manager.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 4/03/25.
//
import Security
import SwiftUI

class TokenManager {
    private static let service = "shapecloud.shapecloudapp.auth"
    
    public static func saveToken(_ token: String) {
       let data = token.data(using: .utf8)!
       let query: [String: Any] = [
           kSecClass as String: kSecClassGenericPassword,
           kSecAttrService as String: service,
           kSecValueData as String: data
       ]
       SecItemDelete(query as CFDictionary) // Remove any existing token, we could also update
       SecItemAdd(query as CFDictionary, nil)
   }

    public static func getToken() -> String? {
       let query: [String: Any] = [
           kSecClass as String: kSecClassGenericPassword,
           kSecAttrService as String: service,
           kSecReturnData as String: kCFBooleanTrue!,
           kSecMatchLimit as String: kSecMatchLimitOne
       ]
       var result: AnyObject?
       let status = SecItemCopyMatching(query as CFDictionary, &result)
       if status == errSecSuccess, let data = result as? Data {
           return String(data: data, encoding: .utf8)
       }
       return nil
   }
}
