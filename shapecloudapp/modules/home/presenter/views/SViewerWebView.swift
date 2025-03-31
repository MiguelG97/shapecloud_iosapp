//
//  SViewerWebView.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 29/03/25.
//
import SwiftUI
import WebKit

struct SViewerWebView: UIViewRepresentable{
    var url: String
    var token: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame:.zero,configuration:webConfiguration)
        webView.allowsBackForwardNavigationGestures = true
        webView.backgroundColor = .red
        webView.isInspectable = true
        print("✅ makeUIView() called")
        return webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let urlforRequest = URL(string: url) else {
            print("❌ Invalid URL:", url)
            return
        }
        var request = URLRequest(url: urlforRequest)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        print("🔄 Loading URL:", url)
        print("🛠 Headers:", request.allHTTPHeaderFields ?? [:])
        
        uiView.load(request)
    }
    
    //coordinator??
}
