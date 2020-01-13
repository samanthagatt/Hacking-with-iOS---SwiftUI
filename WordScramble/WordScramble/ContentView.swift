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
    @State private var showingAlert = false
    @State private var alertMessage = ""
        
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $attemptedWord, onCommit: addAttemptedWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle")
                        .foregroundColor(.gray)
                    Text($0)
                }
            }.navigationBarTitle(rootWord)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Oops"), message: Text(alertMessage), dismissButton: .default(Text("Okay")))
            }
        }
    }
    
    private func updateAlertMessage() {
        alertMessage = "Your answer must be between 1 and \(rootWord.count) characters excluding whitespaces and new lines"
    }
    private func addAttemptedWord() {
        let word = attemptedWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard word.count > 0,
            word.count <= rootWord.count else {
                updateAlertMessage()
                showingAlert = true
                return
        }
        usedWords.insert(word, at: 0)
        attemptedWord = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
