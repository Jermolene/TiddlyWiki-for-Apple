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
        var retryCount: Int = 0
        var maxRetries: Int = 5

        init(parent: WebView) {
            self.parent = parent
        }

        func reload(_ webView: WKWebView) {
            let request = URLRequest(url: parent.url)
            webView.load(request)
        }

        // Handle "connection refused" errors by retrying after 1 second
        // This is to work around the fact that the webview is created before the server is fully up and running
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            if let error = error as? URLError, error.code == .cannotConnectToHost {
                retryCount += 1
                if retryCount <= maxRetries {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.reload(webView)
                    }
                } else {
                    retryCount = 0
                }
            }
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
