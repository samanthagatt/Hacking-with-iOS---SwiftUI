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
    @State private var name = ""
    @State private var selectedStudent = "Harry"
    
    private let students = ["Harry", "Hermione", "Ron"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Button("Tap count: \(tapCount)") {
                        self.tapCount += 1
                    }
                }
                Section {
                    TextField("Enter your name", text: $name)
                    Text("Hello \(name)")
                }
                Section {
                    Picker("Select student", selection: $selectedStudent) {
                        ForEach(0..<students.count) {
                            Text(self.students[$0])
                        }
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
