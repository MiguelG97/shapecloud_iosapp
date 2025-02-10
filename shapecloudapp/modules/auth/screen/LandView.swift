//
//  LoginView.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 2/02/25.
//

import SwiftUI
import WebKit

struct LandView: View {
    
    var videoURL : URL = URL(string: "https://www.youtube.com/embed/todiSVFQOjU?autohide=1&modestbranding=1&controls=1&rel=0&fs=0")!
    
    var body: some View {
        
            
        GeometryReader { proxy in
            let offset = 40.0
            let height = proxy.size.height - offset
            
            ZStack {
                VStack(spacing:0){
                    Spacer(minLength: offset)
                    
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
//                    .background(.red)
                    
                    VStack {
                        SWebView(url: videoURL)
                            .frame(maxWidth: .infinity,maxHeight: 0.35*height)
                    }
                    .frame(maxWidth: .infinity)
                    .background(.yellow)

                    VStack(spacing:20){
                        Button {
                            
                        } label: {
                            Text("Subscribe now").foregroundStyle(.black)
                                .font(.headline)
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity,maxHeight: 50)
                        .border(Color.black, width: 2)
                        
                        
                        Button {
                            
                        } label: {
                            Text("Sign In").foregroundStyle(.white)
                                .font(.headline)
                        }
                        .frame(maxWidth: .infinity,maxHeight: 50)
                        .background(Color.theme.primary)
                    }
                    .frame(maxWidth: .infinity,maxHeight: 0.3*height)
                    
                }
                .padding(.horizontal, 32)
            }
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    LandView().environment(\.font, .custom(ThemeFonts.shared.geistRegular, size: 14))
}
