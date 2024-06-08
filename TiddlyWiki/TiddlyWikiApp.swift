//
//  TiddlyWikiApp.swift
//  TiddlyWiki
//
//  Created by Jeremy Ruston on 09/05/2024.
//

import SwiftUI

@main
struct TiddlyWikiApp: App {
    let nodeQueue = DispatchQueue(label: "node.js")

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    init() {
        // Get the URL for the user's Documents directory
        let documentsURL: URL
        do {
            documentsURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        } catch {
            fatalError("Unable to access Documents directory: \(error)")
        }
        // Define the path for tiddlywiki.info in the Documents directory
        let userFileURL = documentsURL.appendingPathComponent("tiddlywiki.info")
        // Copy the bundled tiddlywiki.info to the Documents directory if it doesn't already exist
        if !FileManager.default.fileExists(atPath: userFileURL.path) {
            if let bundledFileURL = Bundle.main.url(forResource: "tiddlywiki", withExtension: "info", subdirectory: "nodejs-project/editions/server") {
                do {
                    try FileManager.default.copyItem(at: bundledFileURL, to: userFileURL)
                } catch {
                    fatalError("Unable to copy tiddlywiki.info to Documents directory: \(error)")
                }
            } else {
                fatalError("Bundled tiddlywiki.info not found")
            }
        }
        // Kick off Node.js
        let srcPath = Bundle.main.path(forResource: "nodejs-project/tiddlywiki", ofType: "js")
        nodeQueue.async {
            NodeRunner.startEngine(arguments: [
                "node",
                srcPath!,
                documentsURL.path,
                "--version",
                "--listen",
                "host=0.0.0.0"
            ])
        }
    }
}
