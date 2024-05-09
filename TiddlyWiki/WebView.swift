//
//  WebView.swift
//  TiddlyWiki
//
//  Created by Jeremy Ruston on 09/05/2024.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL

    // Creates the WKWebView instance
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    // Updates the WKWebView instance with new data
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
