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
    enum AlertFlag {
        case notInRange
        case duplicate
        case notPossible
        case sameAsRoot
        case notAWord
    }
    
    static var sourceWords: [String] = []
    
    // MARK: State variables
    @State private var usedWords: [String] = []
    @State private var rootWord = "hello"
    @State private var attemptedWord = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var restartAlertShowing = false
    
    // MARK: Subviews
    private var restartButton: some View {
        Button("Restart") { self.restartAlertShowing = true }
            .alert(isPresented: $restartAlertShowing) {
                Alert(title: Text("New game?"),
                      message: Text("Are you sure you'd like to restart? You'll lose all your progress with your current root word."),
                      primaryButton: .destructive(Text("Restart"), action: restartGame),
                      secondaryButton: .cancel())
            }
    }
    
    // MARK: View body
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $attemptedWord, onCommit: addWordIfValid)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                Text(getScore())
                    .font(.headline)
                List(usedWords, id: \.self) {
                    Text($0)
                    Image(systemName: "\($0.count).circle")
                        .foregroundColor(.gray)
                }
            }.navigationBarTitle(rootWord)
            .navigationBarItems(trailing: restartButton)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Oops"), message: Text(alertMessage), dismissButton: .default(Text("Okay")) { self.attemptedWord = "" })
            }
            .onAppear(perform: startGame)
        }
    }
    
    
    // MARK: Struct methods
    private func showAlert(_ error: AlertFlag) {
        switch error {
        case .notInRange:
            alertMessage = "Your answer must be between 2 and \(rootWord.count) characters excluding whitespaces and new lines"
        case .duplicate:
            alertMessage = "You've already got \(attemptedWord)!"
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
        guard let url = Bundle.main.url(forResource: "start", withExtension: "txt") else {
            fatalError("Can't find word source file")
        }
        do {
            ContentView.sourceWords = try String(contentsOf: url).components(separatedBy: "\n")
            rootWord = ContentView.sourceWords.randomElement() ?? "silkworm"
        } catch {
            fatalError("Error reading word source file: \(error)")
        }
    }
    private func restartGame() {
        rootWord = ContentView.sourceWords.randomElement() ?? "silkworm"
        usedWords = []
        attemptedWord = ""
    }
    private func getScore() -> String {
        let count = usedWords.count
        let ending = count == 0 ? "s" : count == 1 ? "!" : "s!"
        return "You've found \(count) word\(ending)"
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
        guard !usedWords.contains(word) else {
            showAlert(.duplicate)
            return nil
        }
        
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
