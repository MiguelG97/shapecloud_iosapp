//
//  NavBarView.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 9/02/25.
//

import SwiftUI

struct SNavBarView: View {
    var body: some View {
        HStack {
            Button {
                
            } label: {
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 25,weight: .semibold))
                    .foregroundStyle(Color.theme.icon_strong)
                    .frame(width: 25,height: 25)
            }
            .padding(.all, 12)
            
            Spacer()
            Text("SHAPECLOUD")
                .font(.headline)
                .fontWeight(.semibold)
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 35,weight: .regular))
                    .foregroundStyle(Color.theme.icon)
            }
            .padding(.all, 5)

        }
        .padding(.horizontal, 12)
        .frame(maxWidth:.infinity,maxHeight:60)
        .background {
            Color.white
        }
    }
}

#Preview {
    SNavBarView()
        .environment(\.font, .custom(ThemeFonts.shared.geistRegular, size: 16))
}
