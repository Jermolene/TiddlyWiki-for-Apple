//
//  NodeRunner.swift
//  TiddlyWiki
//
//  Created by Jeremy Ruston on 01/06/2024.
//

import NodeMobile
import Foundation

public class NodeRunner: NSObject {
    @objc
    public static func startEngine(arguments: [String]) {
        var argv = arguments.map { strdup($0) }
        node_start(Int32(arguments.count), &argv)
    }
}
