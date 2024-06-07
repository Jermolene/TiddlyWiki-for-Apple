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
    @Binding var reloadTrigger: Bool
    @Binding var showSafari: Bool
    @Binding var safariURL: URL?

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(parent: WebView) {
            self.parent = parent
        }

        func reload(_ webView: WKWebView) {
            let request = URLRequest(url: parent.url)
            webView.load(request)
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let url = navigationAction.request.url, navigationAction.navigationType == .linkActivated {
                self.parent.safariURL = url
                self.parent.showSafari = true
                decisionHandler(.cancel)
            } else {
                decisionHandler(.allow)
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        context.coordinator.reload(webView)
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        if reloadTrigger {
            context.coordinator.reload(webView)
        }
    }
}
