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
    @Binding var isLoading: Bool
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame:.zero,configuration:webConfiguration)
        webView.allowsBackForwardNavigationGestures = true
        webView.isInspectable = true
        webView.navigationDelegate = context.coordinator
        
        guard let urlforRequest = URL(string: url) else {
            print("❌ Invalid URL:", url)
            return webView
        }
        var request = URLRequest(url: urlforRequest)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        print("🔄 Loading URL:", url)
        print("🛠 Headers:", request.allHTTPHeaderFields ?? [:])
        
        webView.load(request)
        return webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
    
    //coordinator
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: SViewerWebView

        init(_ parent: SViewerWebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            DispatchQueue.main.async {
                self.parent.isLoading = false  // Hide loading when page loads
            }
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            DispatchQueue.main.async {
                self.parent.isLoading = false  // Hide loading on error
            }
        }
    }
}
