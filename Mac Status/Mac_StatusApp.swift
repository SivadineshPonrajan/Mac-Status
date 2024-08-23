//
//  Mac_StatusApp.swift
//  Mac Status
//
//  Created by Sivadinesh Ponrajan on 23/08/24.
//

import SwiftUI

@main
struct Mac_StatusApp: App {
    @State private var status: String = "1"
    
    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//        
        MenuBarExtra {
            Text("Hello, world!")
            
            Button("One") {
                status = "1"
            }
            .keyboardShortcut("1")
        
            Button("Two") {
                status = "2"
            }
            .keyboardShortcut("2")
        
            Button("Three") {
                status = "3"
            }
            .keyboardShortcut("3")
            
            Divider()
            
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
            .keyboardShortcut("q")

        } label: {
            Image(systemName: "\(status).circle")
                .padding()
        }
    }
}

