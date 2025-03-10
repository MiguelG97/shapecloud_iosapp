//
//  LoginScreen.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 2/02/25.
//

import SwiftUI
import WebKit
import ComposableArchitecture

struct LandScreen: View {
    var store : StoreOf<AuthFeature>
    var videoURL : URL = URL(string: "https://www.youtube.com/embed/todiSVFQOjU?autohide=1&modestbranding=1&controls=1&rel=0&fs=0")!
    @Environment(\.screenSize) private var screenSize
    
    var body: some View {
        
        let offset = 40.0
        let height = screenSize.height - offset
        
        NavigationStack{
            VStack(spacing:0){
                Spacer()
                .frame(maxWidth: .infinity,maxHeight: offset)
                
//                title
                VStack {
                    HStack(alignment:.center,spacing:10){
                        Text("shapecloud")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .frame(alignment: .leading)
                        SLine(lineThichkness: 2)
                    }
                    .frame(maxWidth: .infinity,alignment: .leading)
                    
                    VStack(spacing:34){
                        Text("Digital Twin Solution\nServices")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity,alignment: .leading)
                        
                        Text("Transform your business collaboration by giving your team robust solutions.").font(.title3)
                            .lineSpacing(6)
                            .fontWeight(.regular)
                            .frame(maxWidth: .infinity,alignment: .leading)
                    }
                }
                .frame(maxWidth: .infinity,maxHeight: 0.35*height,alignment: .center)
                
//                webview
                VStack {
                    SWebView(url: videoURL)
                        .frame(maxWidth: .infinity,maxHeight: 0.35*height)
                }
                .frame(maxWidth: .infinity)

//                buttons
                VStack(spacing:20){
                    Button {
                        
                    } label: {
                        Text("Subscribe now")
                            .foregroundStyle(.black)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity,maxHeight: 50)
                            .background(RoundedRectangle(cornerRadius: 25).stroke(Color.black,lineWidth: 2))
                    }
                    
                    
                    NavigationLink {
                        LoginScreen(store: store)
                    } label: {
                        Text("Sign In")
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity,maxHeight: 50)
                                .background(RoundedRectangle(cornerRadius: 25).fill(Color.theme.primary))
                    }
                }
                .font(.headline)
                .frame(maxWidth: .infinity,maxHeight: 0.3*height)
            }
            .padding(.horizontal, 32)
        }.ignoresSafeArea(.all)
    }
}

#Preview {
    LandScreen(store:Sstore.scope(state: \.auth, action: \.auth))
        .environment(\.font, .custom(ThemeFonts.shared.geistRegular, size: 16))
        .environment(\.screenSize, CGSize(width: 402, height: 874))
}
