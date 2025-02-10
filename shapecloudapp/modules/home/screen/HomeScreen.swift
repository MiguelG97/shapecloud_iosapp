//
//  HomeScreen.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 9/02/25.
//

import SwiftUI

struct HomeScreen: View {
    @Environment(\.screenSize) private var screenSize : CGSize
    @Environment(\.safeArea) private var safeArea : EdgeInsets
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                    .frame(maxWidth: .infinity,maxHeight: safeArea.top*0.8)
                SNavBarView()
                
                VStack {
                    
                }
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                .background {
                    Color.red
                }
                
                STabBarView()
                
            }
            .ignoresSafeArea()
            .frame(maxWidth: .infinity,maxHeight: screenSize.height,alignment: .top)
//            List {
//                       NavigationLink("Row", destination: Text("Tapped on row"))
//                   }
//                   .navigationTitle("List")
//                   .navigationBarTitleDisplayMode(.large)
                   
        }
    }
}

#Preview {
    HomeScreen()
        .environment(\.font, .custom(ThemeFonts.shared.geistRegular, size: 16))
        .environment(\.screenSize, CGSize(width: 402, height: 874))
        .environment(\.safeArea, EdgeInsets(top: 62, leading: 0, bottom: 34, trailing: 0))
}
