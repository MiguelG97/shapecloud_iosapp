//
//  SSecureField.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 9/02/25.
//

import SwiftUI

struct SSecureField: View {
    @Binding var password: String
    @State private var isPasswordVisible: Bool = false
    
    
    var label : String = "Password"
    var body: some View {
        VStack(alignment: .leading,spacing:0) {
            Text(label)
                .fontWeight(.semibold)
            
            HStack(alignment:.center) {
                Image(systemName:"lock").foregroundStyle(Color.theme.icon)
                    
                
                if(isPasswordVisible){
                    TextField("password",text: $password)
                        .font(.callout)
                        .textContentType(.password)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                }
                else{
                    SecureField(text: $password, prompt: Text("********")
                        .font(.callout)) {
                    }
                    .textContentType(.password)
                }
                
                Button {
                    isPasswordVisible = !isPasswordVisible;
                } label: {
                    Image(systemName:isPasswordVisible ? "eye.slash": "eye")
                        .foregroundStyle(Color.theme.icon)
                }
            }
            .frame(minHeight: 50)
            .overlay(alignment: .bottom){
                Rectangle().frame(height: 1)
                    .foregroundStyle(.black)
            }
        }
        .font(.callout)
    }
}

#Preview {
    SSecureField(password: .constant(""), label: "Password")
        .environment(\.font, .custom(ThemeFonts.shared.geistRegular, size: 16))
}
