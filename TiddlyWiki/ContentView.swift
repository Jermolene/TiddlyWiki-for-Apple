//
//  ContentView.swift
//  TiddlyWiki
//
//  Created by Jeremy Ruston on 09/05/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Welcome to TiddlyWiki")
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            WebView(url: URL(string: "http://localhost:8080")!)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
