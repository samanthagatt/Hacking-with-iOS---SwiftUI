//
//  ContentView.swift
//  WeSplit
//
//  Created by Samantha Gatt on 1/7/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var tapCount = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("Hello")
                    Group {
                        Text("Hello, World!")
                        Text("I'm in a group with the text above me!")
                    }
                    Text("hello again")
                }
                Section {
                    Text("Woah there. Here's another section")
                    Text("With some more text")
                }
                Section {
                    Button("Tap count: \(tapCount)") {
                        self.tapCount += 1
                    }
                }
            }
            .navigationBarTitle(Text("SwiftUI"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
