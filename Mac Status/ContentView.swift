//
//  ContentView.swift
//  Mac Status
//
//  Created by Sivadinesh Ponrajan on 23/08/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "swift")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("")
            Text("Hello, Shiva!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
