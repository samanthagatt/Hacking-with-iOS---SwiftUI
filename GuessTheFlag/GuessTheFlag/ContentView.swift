//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Samantha Gatt on 1/7/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var answerAlertTitle = ""
    @State private var answerAlertDetail = ""
    @State private var score = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack() {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0..<3) { i in
                    Button(action: {
                        self.showResult(i)
                    }) {
                        FlagImage(name: self.countries[i])
                    }
                }
                Spacer()
                Text("Current Score: \(score)")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }
        }.alert(isPresented: $showingScore) {
            Alert(title: Text(answerAlertTitle), message: Text(answerAlertDetail), dismissButton: .default(Text("Continue")) { self.askNextQuestion()})
        }
    }
    
    private func showResult(_ number: Int) {
        let isCorrect = number == correctAnswer
        answerAlertTitle = isCorrect ? "Correct" : "Wrong"
        answerAlertDetail = isCorrect ? "Good job!" : "That's the flag of \(countries[number])"
        if isCorrect { score += 1 }
        showingScore = true
    }
    
    private func askNextQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
