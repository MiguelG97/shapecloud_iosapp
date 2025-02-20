//
//  LoginScreen.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 5/02/25.
//

import SwiftUI

struct LoginScreen: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @Environment(\.screenSize) private var screensize
    
    var body: some View {
        
        ZStack(alignment:.bottom) {
            SAnimatedMeshGradient()
           
            VStack(spacing:0){
                VStack(spacing: 20) {
                    Text("Login")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    Text("Enter your shapecloud account email address and password")
                        .font(.callout)
                        .foregroundStyle(Color.theme.foreground_muted)
                }
                .frame(maxHeight: screensize.height*0.28)
                
                VStack(spacing:20) {
                    STextField(value: $email,title: "Email",placeholder: "admin@shapecloud.com",icon: Image(systemName: "envelope"))
                    SSecureField(password: $password, label: "Password")
                }
                .frame(maxHeight: screensize.height*0.25)
                
                Button {
                    
                } label: {
                    Text("Login")
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.black)
                        .frame(maxWidth: .infinity, minHeight: 60)
                        .background {
                            RoundedRectangle(cornerSize: CGSize(width: 24, height: 24))
                                .stroke(.black)
                        }
                }
                .offset(y: -10)
                .frame(maxHeight: screensize.height*(0.25))

            }
            .padding(.horizontal, 24)
            .frame(width: screensize.width, height: screensize.height * 0.72)
            .background{
                Color.white
            }
            .clipShape(.rect(topLeadingRadius: 80))
            
        }
        .ignoresSafeArea()
    }
}

#Preview {
    LoginScreen()
        .environment(\.font, .custom(ThemeFonts.shared.geistRegular, size: 16))
        .environment(\.screenSize, CGSize(width: 402, height: 874))
}
