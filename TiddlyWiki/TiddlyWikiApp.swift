//
//  TiddlyWikiApp.swift
//  TiddlyWiki
//
//  Created by Jeremy Ruston on 09/05/2024.
//

import SwiftUI
import Swifter

class HTTPServerManager: ObservableObject {
    @Published var fileContents: String
    let server = HttpServer()

    init() {
        // Get the URL for the user's Documents directory
        let documentsURL: URL
        do {
            documentsURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        } catch {
            fatalError("Unable to access Documents directory: \(error)")
        }

        // Define the path for index.html in the Documents directory
        let userFileURL = documentsURL.appendingPathComponent("index.html")

        // Copy the bundled index.html to the Documents directory if it doesn't already exist
        if !FileManager.default.fileExists(atPath: userFileURL.path) {
            if let bundledFileURL = Bundle.main.url(forResource: "index", withExtension: "html") {
                do {
                    try FileManager.default.copyItem(at: bundledFileURL, to: userFileURL)
                } catch {
                    fatalError("Unable to copy index.html to Documents directory: \(error)")
                }
            } else {
                fatalError("Bundled index.html not found")
            }
        }

        // Initialize fileContents with the contents of index.html from the Documents directory
        do {
            self.fileContents = try String(contentsOf: userFileURL)
        } catch {
            self.fileContents = "Error loading file"
        }

        // Set up the server
        setupServer()
    }

    private func setupServer() {
        server["/"] = { [weak self] request in
            guard let self = self else {
                return .internalServerError
            }

            print("Request: \(request.method) \(request.path) headers: \(request.headers) query: \(request.queryParams)")
            switch request.method {
            case "HEAD":
                return .ok(.text(""))
            case "OPTIONS":
                let headers = ["DAV": "DAV:1"]
                return .raw(200, "OK", headers, nil)
            case "GET":
                return .ok(.htmlBody(self.fileContents))
            case "PUT":
                return self.handlePutRequest(request)
            default:
                return .badRequest(.text("Method not recognised"))
            }
        }

        do {
            try server.start(8080)  // Specifying a port is usually a good practice
            print("Server started on port 8080")
        } catch {
            print("Failed to start server: \(error)")
        }
    }

    func handlePutRequest(_ request: HttpRequest) -> HttpResponse {
        guard let contentType = request.headers["content-type"], contentType.hasPrefix("text/html") else {
            return .badRequest(.text("Invalid content type"))
        }

        let bodyData = Data(request.body)
        guard let bodyString = String(data: bodyData, encoding: .utf8) else {
            return .badRequest(.text("Invalid body data"))
        }

        do {
            let documentsURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileURL = documentsURL.appendingPathComponent("index.html")
            try bodyString.write(to: fileURL, atomically: true, encoding: .utf8)
            self.fileContents = bodyString
            return .ok(.text("Data saved successfully"))
        } catch {
            return .internalServerError
        }
    }
}

@main
struct TiddlyWikiApp: App {
    @StateObject private var serverManager = HTTPServerManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(serverManager)
        }
    }
}
