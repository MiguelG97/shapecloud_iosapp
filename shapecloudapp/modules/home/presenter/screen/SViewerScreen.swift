//
//  SViewerScreen.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 29/03/25.
//

import SwiftUI

struct SViewerScreen: View {

    @State private var isLoading = true
    
    var projectId : String
    var modelId : String
    var webUrl : String {
        "https://shapecloudapp.com/projects/\(projectId)/model/\(modelId)?isWkWebView=true"
    }
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
            SViewerWebView(url: webUrl,token: TokenManager.getToken()!,isLoading: $isLoading){
                dismiss()
            }
            if isLoading{
                VStack {
                    ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(1.5)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SViewerScreen(projectId: "67783151b63edcbb6985b4d3", modelId: "bd76efb7-dbcc-47f9-82a5-00c2939d34e8")
}
