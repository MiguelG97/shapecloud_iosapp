//
//  STextField.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 9/02/25.
//

import SwiftUI

struct STextField<Icon:View>: View {
    @Binding var value: String
    var title: String = "Email"
    var placeholder: String = "admin@shapecloud.com"
    var icon: Icon
    
    var body: some View {
        VStack(alignment:.leading,spacing:0) {
            Text(title)
                .fontWeight(.semibold)
            HStack(alignment:.center){
                icon.foregroundStyle(Color.theme.icon)
                
                TextField("Field", text: $value, prompt: Text(placeholder)
                    .foregroundStyle(Color.theme.foreground_muted))
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
            }
            .font(.callout)
            .frame(minHeight: 50)
            .overlay(alignment: .bottom) {
                Rectangle().frame(height: 1)
                    .foregroundStyle(.black)
            }
            
        }
    }
}

#Preview {
    STextField(value:.constant(""),icon: Image("envelope"))
        .environment(\.font, .custom(ThemeFonts.shared.geistRegular, size: 14))
}
