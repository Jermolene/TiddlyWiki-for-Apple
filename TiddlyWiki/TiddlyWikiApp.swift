//
//  TiddlyWikiApp.swift
//  TiddlyWiki
//
//  Created by Jeremy Ruston on 09/05/2024.
//

import SwiftUI
import Swifter

@main
struct TiddlyWikiApp: App {
    let server = HttpServer()

    init() {
        server["/"] = { request in
            return .ok(.htmlBody("This is a web page served from \(request.path)"))
        }
        do {
            try server.start(8080)  // Specifying a port is usually a good practice
            print("Server started on port 8080")
        } catch {
            print("Failed to start server: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
