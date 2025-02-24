//
//  SFolderBreadCumber.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 23/02/25.
//

import SwiftUI

struct SFolderBreadCumber: View {
    var body: some View {
        HStack {
            Text("Root")
                .foregroundStyle(Color.theme.foreground_muted)
            Image(systemName: "chevron.right")
                .fontWeight(.medium)
            Text("Mep")
                .fontWeight(.medium)
        }
        .frame(maxWidth: .infinity,alignment: .leading)
    }
}

#Preview {
    SFolderBreadCumber()
}
