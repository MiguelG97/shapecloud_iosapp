//
//  LoginView.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 5/02/25.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment:.bottom) {
                SAnimatedMeshGradient()
               
                VStack(spacing:0){
                    VStack(spacing: 20) {
                        Text("Login")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                        Text("Enter your shapecloud account email address and password")
                            .foregroundStyle(Color.theme.foreground_muted)
                    }
                    .frame(maxHeight: proxy.size.height*0.28)
                    
                    VStack(spacing:20) {
                        STextField(value: $email,title: "Email",placeholder: "admin@shapecloud.com",icon: Image(systemName: "envelope"))
                        SSecureField(password: $password, label: "Password")
                    }
                    .frame(maxHeight: proxy.size.height*0.3)
                    
                    Button {
                        
                    } label: {
                        Text("Login")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.white)
                    }
                    .frame(maxWidth: .infinity, minHeight: 60)
                    .background{
                        Color.theme.primary
                    }
                    .frame(maxHeight: proxy.size.height*(0.2))

                }
                .padding(.horizontal, 24)
                .frame(width: proxy.size.width, height: proxy.size.height * 0.72)
                .background{
                    Color.white
                }
                .clipShape(.rect(topLeadingRadius: 140))
                
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    LoginView()
}
