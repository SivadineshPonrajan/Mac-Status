//
//  main.swift
//  Mac Status
//
//  Created by Sivadinesh Ponrajan on 24/08/24.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    @Published var status: String = "1" // Use @Published to bind with SwiftUI

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Create a status item with a fixed length
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "circle.fill", accessibilityDescription: "Menu Bar Icon")
            button.action = #selector(menuBarButtonTapped)
        }
        
        constructMenu()
    }

    @objc func menuBarButtonTapped() {
        print("Menu bar icon clicked!")
    }
    
    func constructMenu() {
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "One", action: #selector(optionOne), keyEquivalent: "1"))
        menu.addItem(NSMenuItem(title: "Two", action: #selector(optionTwo), keyEquivalent: "2"))
        menu.addItem(NSMenuItem(title: "Three", action: #selector(optionThree), keyEquivalent: "3"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(quit), keyEquivalent: "q"))
        
        statusItem?.menu = menu
    }

    @objc func optionOne() {
        status = "1"
        print("Option One selected")
    }

    @objc func optionTwo() {
        status = "2"
        print("Option Two selected")
    }

    @objc func optionThree() {
        status = "3"
        print("Option Three selected")
    }

    @objc func quit() {
        NSApplication.shared.terminate(nil)
    }
}
