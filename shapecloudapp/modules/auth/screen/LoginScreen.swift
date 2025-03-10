//
//  LoginScreen.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 5/02/25.
//

import SwiftUI
import ComposableArchitecture

struct LoginScreen: View {
    var store : StoreOf<AuthFeature>
    @State private var email: String = "mgutierrez@shapecloud.com"
    @State private var password: String = "miguel1234"
    @Environment(\.screenSize) private var screensize
    @Environment(\.dismiss) private var dismiss
    
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
                    Task {
                        do{
                            let responseDto = try await AuthService.shared.Login(loginDto: LoginDto(email: email, password: password, role: USER_ROLES.user))
                            guard responseDto.success else{
                                throw NSError(domain: responseDto.error?.name ?? "Server Error", code: responseDto.statusCode, userInfo: [NSLocalizedDescriptionKey: responseDto.error?.message! ?? "Unexpected Error"])
                            }
                            store.send(.setUser(responseDto.data!.user))
//                            store.send(.setUser(User(_id: "12", name: "Miguel", email: "mgutierrez", role: .user, companyId: "2314")))
                        }
                        catch {
                            print(error.localizedDescription)
                        }
                    }
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
            
        }.ignoresSafeArea()
            .navigationBarBackButtonHidden()
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {dismiss()}) {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                    }
                }
            }
    }
}

#Preview {
    LoginScreen(store:Sstore.scope(state: \.auth, action: \.auth))
        .environment(\.font, .custom(ThemeFonts.shared.geistRegular, size: 16))
        .environment(\.screenSize, CGSize(width: 402, height: 874))
}
