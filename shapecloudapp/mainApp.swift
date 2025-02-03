//
//  shapecloudappApp.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 2/02/25.
//

import SwiftUI

@main
struct MainApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView().statusBarHidden(true)
        }
        .environment(\.font, .custom(ThemeFonts.shared.geistRegular, size: 14))
    }
}
