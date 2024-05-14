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
    let fileContents: String
    let server = HttpServer()
 
    init() {
        // Initialize fileContents with a default value
        if let fileURL = Bundle.main.url(forResource: "index", withExtension: "html"),
           let fileContents = try? String(contentsOf: fileURL) {
            self.fileContents = fileContents
        } else {
            self.fileContents = "Error loading file"
        }

        // Configure the server after fileContents has been initialized
        server["/"] = { [fileContents] request in
            print("Request: \(request.method) \(request.path) headers: \(request.headers) query: \(request.queryParams)")
            return .ok(.htmlBody(fileContents))
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
