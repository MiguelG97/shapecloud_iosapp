//
//  webview.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 4/02/25.
//

import SwiftUI
import WebKit
struct SWebView: UIViewRepresentable{
    var url:URL
    func makeUIView(context: Context) -> WKWebView {
           let webView = WKWebView()
           webView.allowsBackForwardNavigationGestures = true
           return webView
       }
       
       func updateUIView(_ uiView: WKWebView, context: Context) {
           let request = URLRequest(url: url)
           uiView.load(request)
       }
}
