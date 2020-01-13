//
//  ContentView.swift
//  WordScramble
//
//  Created by Samantha Gatt on 1/10/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords: [String] = []
    @State private var rootWord = "hello"
    @State private var attemptedWord = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $attemptedWord, onCommit: addAttemptedWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                List(usedWords, id: \.self) {
                    Text($0)
                }
            }.navigationBarTitle(rootWord)
        }
    }
    
    private func addAttemptedWord() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
