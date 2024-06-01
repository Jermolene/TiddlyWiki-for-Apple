//
//  ContentView.swift
//  TiddlyWiki
//
//  Created by Jeremy Ruston on 09/05/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var reloadTrigger = false

    var body: some View {
        VStack {
            HStack {
                Text("Welcome to TiddlyWiki")
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Button(action: {
                    // Toggle the reload trigger to refresh the WebView
                    DispatchQueue.main.async {
                        reloadTrigger.toggle()
                    }
                }) {
                    Text("Refresh")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            WebView(url: URL(string: "http://localhost:8080")!, reloadTrigger: $reloadTrigger)

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
