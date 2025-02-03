//
//  LaunchView.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 2/02/25.
//

import SwiftUI

struct LaunchView: View {
    
    var body: some View {
        
        GeometryReader { proxy in
            ZStack {
                Image(SImages.shared.launchView)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                Text("SHAPECLOUDAPP").foregroundStyle(.white)
                    .font(.system(size: 32))
                    .fontWeight(.semibold)
                LoaderView().offset(x: 0, y: 100)
                
            }
            .ignoresSafeArea(edges: .all)
        }
    }
}

#Preview {
    LaunchView().environment(\.font, .custom(ThemeFonts.shared.geistRegular, size: 14))
}
