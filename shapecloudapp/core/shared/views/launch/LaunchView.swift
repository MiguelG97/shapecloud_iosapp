//
//  LaunchView.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 2/02/25.
//

import SwiftUI
import ComposableArchitecture
import Dispatch

struct LaunchView: View {
    var store : StoreOf<AppFeature>
    var body: some View {
        
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
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                store.send(.setLaunchScreenVisibility(false))
            }
        }
    }
}

#Preview {
    LaunchView(store: Sstore).environment(\.font, .custom(ThemeFonts.shared.geistRegular, size: 14))
}
