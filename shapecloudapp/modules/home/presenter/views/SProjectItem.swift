//
//  SProjectItem.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 14/02/25.
//

import SwiftUI

struct SProjectItem: View {
    var body: some View {
        VStack(alignment:.leading) {
            VStack(alignment:.leading) {
                HStack {
                    Image(systemName: "building")
                        .frame(width: 50,height: 50)
                    
                    VStack(alignment:.leading) {
                        Text("Huascar 320")
                            .fontWeight(.semibold)
                        Text("Lima")
                            .foregroundStyle(Color.theme.foreground.opacity(0.5))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(systemName: "ellipsis")
                        .foregroundStyle(Color.theme.icon)
                        .frame(width: 25,height: 30)
                        .rotationEffect(.degrees(90))
                        .scaledToFill()
                        .background {
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.theme.foreground_muted,lineWidth: 0.6)
                        }
                }
                .padding(.trailing,12)
                
                
                HStack {
                    Text("No project description")
                        .foregroundStyle(Color.theme.foreground)
                }
                .padding(.horizontal,12)
            }
            .padding(.top,8)
            .padding(.bottom,12)
            .frame(maxWidth: .infinity,alignment: .leading)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.theme.foreground_muted,lineWidth: 0.6)
            }
            
            HStack {
                Image(systemName: "calendar")
                Text("January 10, 2025")
                    
            }
            .padding(.horizontal, 12)
            .padding(.vertical,8)
            .foregroundStyle(Color.theme.foreground.opacity(0.5))
            .font(.system(size: 14))
        }
        .padding(4)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.theme.foreground_muted,lineWidth: 0.6)
        }
    }
}

#Preview {
    SProjectItem().environment(\.font, .custom(ThemeFonts.shared.geistRegular, size: 16))
        .environment(\.screenSize, CGSize(width: 402, height: 874))
        .environment(\.safeArea, EdgeInsets(top: 62, leading: 0, bottom: 34, trailing: 0))
}
