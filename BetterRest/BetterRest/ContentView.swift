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
    @State private var calculationTitle = ""
    @State private var calculationDescription = ""
    @State private var calculationShowing = false
    
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
    
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
                .alert(isPresented: $calculationShowing) {
                    Alert(title: Text(calculationTitle), message: Text(calculationDescription), dismissButton: .default(Text("Okay")))
            }
        }
    }
    
    private func calculateBedtime() {
        let model = SleepCalculator()
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: wakeUpDate)
        let hoursInMin = (dateComponents.hour ?? 0) * 60
        let minutes = dateComponents.minute ?? 0
        
        do {
            let prediction = try model.prediction(wake: Double(hoursInMin + minutes), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUpDate - prediction.actualSleep
            calculationTitle = "Your ideal bedtime is"
            calculationDescription = dateFormatter.string(from: sleepTime)
        } catch {
            calculationTitle = "Oops!"
            calculationDescription = "Looks like something went wrong. Error: \(error)"
        }
        calculationShowing = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
