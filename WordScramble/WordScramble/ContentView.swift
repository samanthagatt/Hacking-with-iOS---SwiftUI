//
//  ContentView.swift
//  WordScramble
//
//  Created by Samantha Gatt on 1/10/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    private let names = ["Samantha", "Sarah", "Stephanie", "Melanie"]
    
    private var staticList: some View {
        List {
            Section(header: Text(":)")) {
                Text("Hello, world!")
            }
            Section(header: Text(":(")) {
                Text("Goodbye, world.")
            }
        }.listStyle(GroupedListStyle()) // same style as `Form`
    }
    private var dynamicList: some View {
        List(names, id: \.self) {
            Text($0)
        }
    }
    private var mixedList: some View {
        List {
            Section(header: Text("Section 1")) {
                ForEach(names, id: \.self) {
                    Text($0)
                }
            }
            Section(header: Text("Section 2")) {
                Text("Here's a static cell!")
            }
            Section(header: Text("Section 3")) {
                Text("And another!")
            }
        }
    }
    
    var body: some View {
        VStack() {
            staticList
            Color.orange.frame(height: 1)
            mixedList
            Color.orange.frame(height: 1)
            dynamicList
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
