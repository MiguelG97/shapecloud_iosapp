//
//  environment.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 9/02/25.
//
import SwiftUI

struct ScreenSizeKey: EnvironmentKey {
    static let defaultValue: CGSize = .zero
}
struct SafeAreaKey: EnvironmentKey {
    static let defaultValue: EdgeInsets = .init(top: 60, leading: 0, bottom: 60, trailing: 0)
}

extension EnvironmentValues{
    var screenSize : CGSize {
        get {self[ScreenSizeKey.self]}
        set {self[ScreenSizeKey.self] = newValue}
    }
    var safeArea : EdgeInsets {
        get {self[SafeAreaKey.self]}
        set {self[SafeAreaKey.self] = newValue}
    }
}
