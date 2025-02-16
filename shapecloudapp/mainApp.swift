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
            GeometryReader { proxy in
                HomeScreen()
                    .environment(\.screenSize, proxy.size)
                    .environment(\.safeArea, proxy.safeAreaInsets)
                    .onAppear {
                        print(proxy.safeAreaInsets.top,proxy.safeAreaInsets.bottom,
                              proxy.size.height)
                    }
            }
            
        }
        .environment(\.font, .custom(ThemeFonts.shared.geistRegular, size: 16))
    }
}
