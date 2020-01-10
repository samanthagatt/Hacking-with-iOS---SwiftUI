//
//  ContentView.swift
//  BetterRest
//
//  Created by Samantha Gatt on 1/9/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var wakeUpDate = Date()
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    private var wakeUpStack: some View {
        VStack {
            Text("When do you want to wake up?")
                .font(.headline)
            DatePicker("Please enter a time", selection: $wakeUpDate, displayedComponents: .hourAndMinute)
            .labelsHidden()
        }
    }
    private var sleepAmountStack: some View {
        VStack {
            Text("Desired amount of sleep")
                .font(.headline)
            Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                Text("\(sleepAmount, specifier: "%g") hours")
            }
        }
    }
    private var coffeeAmountStack: some View {
        VStack {
            Text("Daily coffee intake")
                .font(.headline)
            Stepper(value: $coffeeAmount, in: 0...20) {
                Text("\(coffeeAmount) \(coffeeAmount == 1 ? "cup" : "cups")")
            }
        }
    }
    private var calculateButton: some View {
        Button(action: calculateBedtime) {
            Text("Calculate")
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                wakeUpStack
                sleepAmountStack
                coffeeAmountStack
            }.navigationBarTitle("BetterRest")
            .navigationBarItems(trailing: calculateButton)
        }
    }
    
    private func calculateBedtime() {
        // TODO: implement function
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
