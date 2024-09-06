//
//  Mac_StatusApp.swift
//  Mac Status
//
//  Created by Sivadinesh Ponrajan on 23/08/24.
//

import SwiftUI
import Network

class TCPServer: ObservableObject {
    private var listener: NWListener?
    @Published var status: String = "arrow.down"
    @Published var isRunning: Bool = false
    
    func start() {
        setupListener()
    }
    
    func stop() {
        listener?.cancel()
        listener = nil
        isRunning = false
    }
    
    private func setupListener() {
        do {
            listener = try NWListener(using: .tcp, on: 12345)
            listener?.stateUpdateHandler = { state in
                switch state {
                case .ready:
                    print("Server is ready to accept connections")
                    DispatchQueue.main.async {
                        self.isRunning = true
                    }
                case .failed(let error):
                    print("Server failed with error: \(error)")
                    self.stop()
                case .cancelled:
                    print("Server was cancelled")
                default:
                    break
                }
            }
            
            listener?.newConnectionHandler = { connection in
                connection.stateUpdateHandler = { state in
                    if state == .ready {
                        self.handleConnection(connection)
                    }
                }
                connection.start(queue: .main)
            }
            
            listener?.start(queue: .main)
        } catch {
            print("Failed to create listener: \(error)")
        }
    }
    
    private func handleConnection(_ connection: NWConnection) {
        connection.receive(minimumIncompleteLength: 1, maximumLength: 65536) { content, _, isComplete, error in
            if let data = content, let message = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    self.status = message.trimmingCharacters(in: .whitespacesAndNewlines)
//                    print("The status is: \(self.status)")
                }
            }
            
            if !isComplete {
                self.handleConnection(connection)
            }
        }
    }
}

@main
struct Mac_StatusApp: App {
    @StateObject private var server = TCPServer()
    
    var body: some Scene {
        MenuBarExtra {
//            Text("Current Status: \(server.status)")
            
            Button(server.isRunning ? "Stop" : "Start") {
                if server.isRunning {
                    server.stop()
                    server.status = "arrow.down"
                } else {
                    server.start()
                    server.status = "arrow.up"
                }
            }
            .keyboardShortcut(server.isRunning ? "s" : "r")
            
            Divider()
            
            Button("Quit") {
                server.stop()
                NSApplication.shared.terminate(nil)
            }
            .keyboardShortcut("q")

        } label: {
            Image(systemName: "\(server.status).circle")
                .padding()
        }
    }
}


// Command to change the status
// echo "1" | nc -w 0 localhost 12345
