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
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    
    private let tipPercentages = [10, 15, 20, 25, 0]
    private var totalPlusTip: Double {
        let tipPercent = Double(tipPercentages[tipPercentage])
        let billAmount = Double(checkAmount) ?? 0.0
        let tipAmount = billAmount * (tipPercent / 100)
        return billAmount + tipAmount
    }
    private var amountPerPerson: Double {
        let peopleCount = Double(numberOfPeople) ?? 1
        return totalPlusTip / peopleCount
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Check Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    TextField("Number of People", text: $numberOfPeople)
                        .keyboardType(.numberPad)
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
