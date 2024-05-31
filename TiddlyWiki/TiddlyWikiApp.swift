//
//  TiddlyWikiApp.swift
//  TiddlyWiki
//
//  Created by Jeremy Ruston on 09/05/2024.
//

import SwiftUI

@main
struct TiddlyWikiApp: App {
    @StateObject private var serverManager = HTTPServerManager()
    let nodeQueue = DispatchQueue(label: "node.js")

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(serverManager)
        }
    }
    
    init() {
        let srcPath = Bundle.main.path(forResource: "nodejs-project/main.js", ofType: "")
        nodeQueue.async {
            NodeRunner.startEngine(arguments: [
                "node",
                srcPath!,
            ])
        }
    }
}
