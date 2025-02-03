//
//  theme.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 2/02/25.
//

import SwiftUI

extension Color {
    static let theme: ThemeColor = ThemeColor()
}

struct ThemeColor {
    let primary = Color("app-primary")
    let icon = Color("icon")
    let icon_strong = Color("icon-strong")
    let foreground = Color("foreground")
    let foreground_muted = Color("foreground-muted")
    let border = Color("border")
    let error = Color("error")
    let error_light = Color("error-light")
}
