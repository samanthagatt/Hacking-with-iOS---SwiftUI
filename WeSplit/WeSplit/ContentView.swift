//
//  ContentView.swift
//  WeSplit
//
//  Created by Samantha Gatt on 1/7/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    
    private let tipPercentages = [10, 15, 20, 25, 0]
    private var totalPlusTip: Double {
        let tipPercent = Double(tipPercentages[tipPercentage])
        let billAmount = Double(checkAmount) ?? 0.0
        let tipAmount = billAmount * (tipPercent / 100)
        return billAmount + tipAmount
    }
    private var amountPerPerson: Double {
        // number of people range starts at 2 with 0 indexing so add 2
        let peopleCount = Double(numberOfPeople + 2)
        return totalPlusTip / peopleCount
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Check Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Total including tip")) {
                    Text("$\(totalPlusTip, specifier: "%.2f")") 
                }
                Section(header: Text("Amount per person")) {
                    Text("$\(amountPerPerson, specifier: "%.2f")")
                }
            }.navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
