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
            WebView(url: URL(string: "http://localhost:8080")!)
                .edgesIgnoringSafeArea(.all)
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("This is SwiftUI text!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
