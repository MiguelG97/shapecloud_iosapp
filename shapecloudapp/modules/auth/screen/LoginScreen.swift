//
//  LoginScreen.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 5/02/25.
//

import SwiftUI
import ComposableArchitecture
import Combine

struct LoginScreen: View {
    var store : StoreOf<AuthFeature>
    @State private var email: String = ""
    @State private var password: String = ""
    @Environment(\.screenSize) private var screensize
    @Environment(\.safeArea) private var safeArea
    @Environment(\.dismiss) private var dismiss
    
    @State private var isLoading : Bool = false
    @StateObject  private var keyboardObserver = KeyboardObserver()
    
    var body: some View {
        
        ZStack(alignment:.bottom) {
            SAnimatedMeshGradient()
           
            VStack(spacing:0){
                VStack(spacing: 20) {
                    Text("Login")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.theme.foreground)
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
                            isLoading = true
                            defer{
                                isLoading = false
                            }
                            
                            let responseDto = try await AuthService.shared.Login(loginDto: LoginDto(email: email, password: password, role: USER_ROLES.user))
                            guard responseDto.success else{
                                throw NSError(domain: responseDto.error?.name ?? "Server Error", code: responseDto.statusCode, userInfo: [NSLocalizedDescriptionKey: responseDto.error?.message! ?? "Unexpected Error"])
                            }
                            store.send(.setUser(responseDto.data!.user))
                        }
                        catch {
                            print(error.localizedDescription)
                        }
                    }
                } label: {
                    //great transition!
                    //https://dribbble.com/shots/4260546-Login-loading-app-screen
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
                .offset(y: -keyboardObserver.keyboardHeight)
            .animation(.easeOut(duration: 0.25), value: keyboardObserver.keyboardHeight)
            
        }
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
        .ignoresSafeArea()
        .onReceive(keyboardObserver.$keyboardHeight) { newHeight in
            print("📏 Keyboard height changed:", newHeight)
            print("screen size height",screensize.height)
        }
    }
}

class KeyboardObserver: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0
    private var cancellables: Set<AnyCancellable> = []

    init() {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .sink { notification in
                if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    self.keyboardHeight = keyboardFrame.size.height
                }
            }
            .store(in: &cancellables)

        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .sink { _ in
                self.keyboardHeight = 0
            }
            .store(in: &cancellables)
    }
}


#Preview {
    LoginScreen(store:Sstore.scope(state: \.auth, action: \.auth))
        .environment(\.font, .custom(ThemeFonts.shared.geistRegular, size: 16))
        .environment(\.screenSize, CGSize(width: 440, height: 874))
}
