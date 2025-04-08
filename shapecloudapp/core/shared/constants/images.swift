//
//  images.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 3/02/25.
//
struct SImages {
    private static var _instance : SImages?
    private init() {
        
    }
    public static var shared: SImages {
        if _instance == nil {
            _instance = SImages()
        }
        return _instance!
    }
    
    let launchView: String = "LaunchView"
    let iconStretched: String = "sc_stretched"
}
