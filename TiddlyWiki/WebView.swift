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

    class Coordinator {
        var parent: WebView

        init(parent: WebView) {
            self.parent = parent
        }

        func reload(_ webView: WKWebView) {
            let request = URLRequest(url: parent.url)
            webView.load(request)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        context.coordinator.reload(webView)
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        if reloadTrigger {
            context.coordinator.reload(webView)
        }
    }
}
