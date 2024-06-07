//
//  ContentView.swift
//  TiddlyWiki
//
//  Created by Jeremy Ruston on 09/05/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var reloadTrigger = false
    @State private var showDocumentView = false
    @State private var showSafari = false
    @State private var safariURL: URL?
    @State private var documentFilename: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                WebView(url: URL(string: "http://localhost:8080")!, reloadTrigger: $reloadTrigger, showSafari: $showSafari, safariURL: $safariURL)
                    .ignoresSafeArea()
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Text("TiddlyWiki")
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Toggle the reload trigger to refresh the WebView
                        DispatchQueue.main.async {
                            reloadTrigger.toggle()
                        }
                    }) {
                        Image(systemName: "arrow.clockwise")
                    }

                    Menu {
                        Button("Help", systemImage: "questionmark") {
                            documentFilename = "Help"
                            showDocumentView = true
                        }
                        Button("Credits", systemImage: "star") {
                            documentFilename = "Credits"
                            showDocumentView = true
                        }
                        Button("About", systemImage: "info") {
                            documentFilename = "About"
                            showDocumentView = true
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
            .fullScreenCover(isPresented: $showSafari) {
                SafariView(url: $safariURL)
            }
            .sheet(isPresented: $showDocumentView) {
                DocumentView(showDocumentView: $showDocumentView, filename: $documentFilename)
            }
        }
    }
}

#Preview {
    ContentView()
}
