//
//  RTFView.swift
//  TiddlyWiki
//
//  Created by Jeremy Ruston on 06/06/2024.
//

import SwiftUI

struct RTFView: UIViewRepresentable {
    var filename: String

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.backgroundColor = .clear
        if let rtfPath = Bundle.main.url(forResource: filename, withExtension: "rtf"),
           let attributedString = try? NSAttributedString(url: rtfPath, options: [.documentType: NSAttributedString.DocumentType.rtf], documentAttributes: nil) {
            textView.attributedText = attributedString
        }
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        // Update the view if needed
    }
}


#Preview {
    RTFView(filename: "About")
}
