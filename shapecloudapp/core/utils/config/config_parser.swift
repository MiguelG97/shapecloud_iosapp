//
//  config_parser.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 3/03/25.
//

import Foundation

struct Config {
    static func getValue(for key: String) -> String? {
        return Bundle.main.object(forInfoDictionaryKey: key) as? String
    }
}
