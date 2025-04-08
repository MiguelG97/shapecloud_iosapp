//
//  SSearchField.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 14/02/25.
//

import SwiftUI

struct SSearchField: View {
    @Binding var searchValue: String
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search", text: $searchValue, prompt: Text("Search project"))
                .foregroundStyle(Color.theme.foreground.opacity(0.5))
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .frame(maxWidth: .infinity)
        }
        .fontWeight(.medium)
        .foregroundStyle(.iconStrong)
        .padding(.horizontal, 24)
        .padding(.vertical,14)
        .background {
            Color.white
        }
        .clipShape(.rect(cornerSize: CGSize(width: 20, height: 20)))
        .shadow(color:.black.opacity(0.1),radius: 4,x: 0,y: 5)
    }
}

#Preview {
    SSearchField(searchValue: .constant(""))
        .environment(\.font, .custom(ThemeFonts.shared.geistRegular, size: 16))
}
