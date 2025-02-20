//
//  SFoldersScreen.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 16/02/25.
//

import SwiftUI

    struct SFoldersScreen: View {
        var body: some View {
            VStack {
                HStack {
                    Text("Root")
                    Image(systemName: "chevron.right")
                    Text("Mep")
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                
                VStack(alignment:.leading) {
                    Text("Folders")
                        .font(.title2)
                        .fontWeight(.bold)
                    HStack {
                        ScrollView(.horizontal) {
                            
                        }
                    }
                    .background {
                        Color.red
                    }
                }
            }
            
        }
    }

#Preview {
    SFoldersScreen()
        .environment(\.font, .custom(ThemeFonts.shared.geistRegular, size: 16))
        .environment(\.screenSize, CGSize(width: 402, height: 874))
        .environment(\.safeArea, EdgeInsets(top: 62, leading: 0, bottom: 34, trailing: 0))
}
