//
//  SFolderBreadCumber.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 23/02/25.
//

import SwiftUI

struct SFolderBreadCumber: View {
    @Binding var selectedFolder : TreeViewBaseItem?
    
    var body: some View {
        HStack {
            if selectedFolder != nil {
                Text("Root")
                    .foregroundStyle(Color.theme.foreground_muted)
                Image(systemName: "chevron.right")
                    .fontWeight(.medium)
                Text(selectedFolder!.label)
                    .fontWeight(.medium)
            }
            else{
                
            }
            
        }
        .frame(maxWidth: .infinity,alignment: .leading)
        .background {
            Color.white
        }
    }
}

#Preview {
    SFolderBreadCumber(selectedFolder: .constant(TreeViewBaseItem(id: "1", label: "Structure", children: [])))
}
