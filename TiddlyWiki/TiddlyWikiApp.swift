//
//  TiddlyWikiApp.swift
//  TiddlyWiki
//
//  Created by Jeremy Ruston on 09/05/2024.
//

import SwiftUI

@main
struct TiddlyWikiApp: App {
    var httpServer = HTTPServer(port: 8080)
    init() {
        do {
            try httpServer.start()
        } catch {
            print("Failed to start the server: \(error)")
        }
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
