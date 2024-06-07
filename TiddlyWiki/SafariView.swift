//
//  SafariView.swift
//  TiddlyWiki
//
//  Created by Jeremy Ruston on 06/06/2024.
//

import SwiftUI
import WebKit
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    @Binding var url: URL?
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        if let url = url {
            return SFSafariViewController(url: url)
        } else {
            // Provide a default URL or handle the nil case appropriately
            return SFSafariViewController(url: URL(string: "about:blank")!)
        }
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
        // If the URL changes, you may want to update the SFSafariViewController instance
        if let url = url {
            uiViewController.dismiss(animated: false) {
                let newController = SFSafariViewController(url: url)
                if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = scene.windows.first {
                    window.rootViewController?.present(newController, animated: false, completion: nil)
                }
            }
        }
    }
}
