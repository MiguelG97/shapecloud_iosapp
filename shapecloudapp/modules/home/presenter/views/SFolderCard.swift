//
//  SFolderCard.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 22/02/25.
//

import SwiftUI

struct SFolderCard: View {
    var folderItem : TreeViewBaseItem
    
    @Environment(\.screenSize) var screenSize: CGSize;
    private var widthCard: Double {
        screenSize.width * 0.5 - SScreenSize.hPadding - 10
    }
    private var heightCard: Double {
        0.8 * widthCard
    }
    
    var body: some View {
        VStack(spacing: 0){
            HStack(alignment:.top) {
                Image(systemName: "folder.fill")
                    .font(.system(size: 36))
                    .foregroundStyle(Color.theme.primary)
                Spacer()
                Button{
                    
                }label:{
                    Image(systemName: "ellipsis")
                        .font(.system(size: 24))
                        .foregroundStyle(Color.theme.foreground_muted)
                        .offset(y:5)
                }
            }
            Spacer()
            Text(folderItem.label)
                .fontWeight(.bold)
                .frame(maxWidth:.infinity,alignment:.leading)
            Spacer()
            HStack {
                Text("2 files")
                Spacer()
                Text("2 KB")
                    .fontWeight(.bold)
            }
        }
        .padding(.horizontal,12)
        .padding(.vertical,20)
        .frame(width: widthCard, height: heightCard)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.theme.border,lineWidth: 2)
        }
        .contentShape(Rectangle()) //entirely hittable
        .foregroundStyle(Color.theme.foreground)
    }
}

#Preview {
    SFolderCard(folderItem: TreeViewBaseItem(id: "1", label: "Architecture"))
        .environment(\.font, .custom(ThemeFonts.shared.geistRegular, size: 16))
        .environment(\.screenSize, CGSize(width: 402, height: 874))
}
