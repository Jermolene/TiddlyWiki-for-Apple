//
//  HTTPServer.swift
//  TiddlyWikiProto1
//
//  Created by Jeremy Ruston on 08/05/2024.
//

import Foundation
import Network

class HTTPServer {
    private var listener: NWListener?
    private let port: NWEndpoint.Port

    init(port: UInt16) {
        self.port = NWEndpoint.Port(rawValue: port) ?? 8080
    }

    func start() throws {
        listener = try NWListener(using: .tcp, on: port)
        listener?.stateUpdateHandler = { state in
            print("Server state: \(state)")
            if case .failed(let error) = state {
                print("Server failed with error: \(error)")
                self.stop()
            }
        }
        
        listener?.newConnectionHandler = { connection in
            connection.start(queue: .main)
            self.handleConnection(connection)
        }
        
        listener?.start(queue: .main)
    }
    
    func stop() {
        listener?.cancel()
        listener = nil
    }
    
    private func handleConnection(_ connection: NWConnection) {
        connection.receive(minimumIncompleteLength: 1, maximumLength: 65536) { (data, _, isComplete, error) in
            if let data = data, let requestString = String(data: data, encoding: .utf8) {
                print("Received request: \(requestString)")
                self.respond(to: connection, request: requestString)
            }
            if isComplete {
                connection.cancel()
            } else if let error = error {
                print("Error receiving data: \(error)")
                connection.cancel()
            } else {
                self.handleConnection(connection) // Continue receiving data
            }
        }
    }
    
    private func respond(to connection: NWConnection, request: String) {
        let httpResponse = "HTTP/1.1 200 OK\r\nContent-Type: text/html; charset=UTF-8\r\n\r\n<h1>Hello, this is a a minimal possible webpage!</h1>"
        let data = httpResponse.data(using: .utf8)!
        connection.send(content: data, completion: .contentProcessed({ sendError in
            if let sendError = sendError {
                print("Failed to send response: \(sendError)")
            }
            connection.cancel()
        }))
    }
}
