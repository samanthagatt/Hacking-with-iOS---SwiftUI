//
//  ContentView.swift
//  BetterRest
//
//  Created by Samantha Gatt on 1/9/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var sleepAmount: Double = 8
    @State private var wakeUp = Date()
    
    private var sleepAmountStepper: some View {
        Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
            Text("\(sleepAmount, specifier: "%g") hours")
        }
    }
    private var wakeUpDatePicker: some View {
        DatePicker("Please enter a date", selection: $wakeUp, displayedComponents: .hourAndMinute).labelsHidden()
    }
    
    var body: some View {
        VStack {
            sleepAmountStepper
            wakeUpDatePicker
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
