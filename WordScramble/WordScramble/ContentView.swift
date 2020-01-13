//
//  ContentView.swift
//  WordScramble
//
//  Created by Samantha Gatt on 1/10/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: Validation Error enum
    enum ValidationError {
        case notInRange
        case duplicate
        case notPossible
        case sameAsRoot
        case notAWord
    }
    
    // MARK: State variables
    /// Words the user has entered whether or not they are valid
    @State private var attemptedWords: Set<String> = []
    /// Valid words that the user has entered
    @State private var usedWords: [String] = []
    @State private var rootWord = "hello"
    @State private var attemptedWord = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    // MARK: View body
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $attemptedWord, onCommit: addWordIfValid)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                List(usedWords, id: \.self) {
                    Text($0)
                    Image(systemName: "\($0.count).circle")
                        .foregroundColor(.gray)
                }
            }.navigationBarTitle(rootWord)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Oops"), message: Text(alertMessage), dismissButton: .default(Text("Okay")) { self.attemptedWord = "" })
            }
            .onAppear(perform: startGame)
        }
    }
    
    
    // MARK: Struct methods
    private func showAlert(_ error: ValidationError) {
        switch error {
        case .notInRange:
            alertMessage = "Your answer must be between 2 and \(rootWord.count) characters excluding whitespaces and new lines"
        case .duplicate:
            alertMessage = "You've already tried \(attemptedWord)!"
        case .notPossible:
            alertMessage = "That's not a possible letter combination!"
        case .sameAsRoot:
            alertMessage = "That's the root word!"
        case .notAWord:
            alertMessage = "\(attemptedWord) isn't a word!"
        }
        showingAlert = true
    }
    private func startGame() {
        guard let url = Bundle.main.url(forResource: "start", withExtension: "txt") else { fatalError("Can't find word source file")}
        do {
            let allWords = try String(contentsOf: url).components(separatedBy: "\n")
            rootWord = allWords.randomElement() ?? "silkworm"
        } catch {
            fatalError("Error reading word source file: \(error)")
        }
    }
    private func validateAttemptedWord() -> String? {
        let word = attemptedWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard word.count > 1,
            word.count <= rootWord.count else {
                showAlert(.notInRange)
                return nil
        }
        
        // Makes sure attempted word is not rootWord
        guard word != rootWord else {
            showAlert(.sameAsRoot)
            return nil
        }
        
        // Makes sure attempted word is a possible combination of letters
        var tempRoot = rootWord
        for letter in word {
            guard let i = tempRoot.firstIndex(of: letter) else {
                showAlert(.notPossible)
                return nil
            }
            tempRoot.remove(at: i)
        }
        
        // Makes sure user hasn't already tried that word
        guard !attemptedWords.contains(word) else {
            showAlert(.duplicate)
            return nil
        }
        attemptedWords.insert(word)
        
        // Makes sure attempted word is spelled correctly
        let range = NSRange(location: 0, length: word.utf16.count)
        let mispelledRange = UITextChecker().rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        guard mispelledRange.location == NSNotFound else {
            showAlert(.notAWord)
            return nil
        }
        
        return word
    }
    private func addWordIfValid() {
        guard let word = validateAttemptedWord() else { return }
        usedWords.insert(word, at: 0)
        attemptedWord = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
