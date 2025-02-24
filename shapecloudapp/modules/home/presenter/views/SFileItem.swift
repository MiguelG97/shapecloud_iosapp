//
//  SFileItem.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 23/02/25.
//

import SwiftUI

struct SFileItem: View {
    var body: some View {
        HStack {
            Image(systemName: "document.fill")
                .resizable()
                .foregroundStyle(Color.theme.primary)
                .scaledToFit()
                .padding(8)
                .frame(width: 50,height: 50)
            VStack(alignment:.leading) {
                Text("Huascar 3025 - Arch ")
                    .fontWeight(.semibold)
                Text("7/14/22")
                    .foregroundStyle(Color.theme.foreground_muted)
                    .font(.footnote)
            }
            Spacer()
            Image(systemName: "ellipsis")
                .foregroundStyle(Color.theme.foreground_muted)
        }.frame(maxWidth: .infinity)
    }
}

#Preview {
    SFileItem()
}
