//
//  fonts.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 2/02/25.
//

struct ThemeFonts{
    private static var _instance: ThemeFonts?
    private init(){}
    public static var shared: ThemeFonts {
        if _instance == nil {
            _instance = ThemeFonts()
        }
        return _instance!
    }
    
    let geistBlack: String = "Geist-Black"
    let geistBold: String = "Geist-Bold"
    let geistExtraBold: String = "Geist-ExtraBold"
    let geistExtraLight: String = "Geist-ExtraLight"
    let geistLight: String = "Geist-Light"
    let geistMedium: String = "Geist-Medium"
    let geistRegular: String = "Geist-Regular"
    let geistSemiBold: String = "Geist-SemiBold"
    let geistThin: String = "Geist-Thin"
}

