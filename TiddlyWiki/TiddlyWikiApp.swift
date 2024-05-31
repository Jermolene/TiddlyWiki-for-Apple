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
        let srcPath = Bundle.main.path(forResource: "nodejs-project/main.js", ofType: "")
        nodeQueue.async {
            NodeRunner.startEngine(arguments: [
                "node",
                srcPath!,
            ])
        }
    }
}
