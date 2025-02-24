//
//  SFoldersScreen.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 16/02/25.
//

import SwiftUI

struct SFoldersScreen: View {
    @Binding var areBarsHidden: Bool
    
    var body: some View {
        VStack(spacing:12){
            SFolderBreadCumber()
            
            VStack(alignment:.leading,spacing: 0) {
                Text("Folders")
                    .font(.title2)
                    .fontWeight(.bold)
                
                ScrollView(.horizontal) {
                    HStack(spacing:16) {
                        ForEach(0..<10, id: \.self) { index in
                            SFolderCard()
                        }
                    }
                }
                
            }
            VStack(alignment:.leading) {
                Text("Files")
                    .font(.title2)
                    .fontWeight(.bold)
                
                ScrollView {
                    VStack {
                        
                        ForEach(0..<10, id: \.self) { index in
                            SFileItem()
                        }
                    }
                }
            }
        }
        .padding(.top,12)
        .padding(.horizontal, SScreenSize.hPadding)
        .onAppear {
            withAnimation(.easeInOut(duration: 0.5)) {
                areBarsHidden = true
            }
        }
        .onDisappear {
            withAnimation(.easeInOut(duration: 0.5)) {
                areBarsHidden = false
            }
        }
        
    }
}

#Preview {
    SFoldersScreen(areBarsHidden: .constant(false))
        .environment(\.font, .custom(ThemeFonts.shared.geistRegular, size: 16))
        .environment(\.screenSize, CGSize(width: 402, height: 874))
        .environment(\.safeArea, EdgeInsets(top: 62, leading: 0, bottom: 34, trailing: 0))
}
