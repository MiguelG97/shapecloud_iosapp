//
//  SViewerScreen.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 29/03/25.
//

import SwiftUI

struct SViewerScreen: View {

    //show a loading indicator while the webview initialize!
    var projectId : String
    var modelId : String
    var webUrl : String {
        "https://shapecloudapp.com/projects/\(projectId)/model/\(modelId)"
    }
    
    var body: some View {
        SViewerWebView(url: webUrl,token: TokenManager.getToken()!)
            .ignoresSafeArea()
    }
}

#Preview {
    SViewerScreen(projectId: "67783151b63edcbb6985b4d3", modelId: "bd76efb7-dbcc-47f9-82a5-00c2939d34e8")
}
