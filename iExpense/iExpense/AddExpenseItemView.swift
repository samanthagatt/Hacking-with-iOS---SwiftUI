//
//  AddExpenseView.swift
//  iExpense
//
//  Created by Samantha Gatt on 1/16/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import SwiftUI

struct AddExpenseView: View {
    
    enum AlertReason: String {
        case noName = "Name"
        case noType = "Type"
        case noAmount = "Amount"
        case amountNotANumber
    }
    
    // MARK: Environment
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: Observed properties
    @ObservedObject var expenses: Expenses
    
    // MARK: Static properties
    static var types = ["Business"
    , "Personal", "Education"]
    
    // MARK: State properties
    @State private var name = ""
    @State private var type = ""
    @State private var amount = ""
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var alertIsShowing = false
    
    // MARK: Subviews
    private var saveButton: some View {
        Button("Save") {
            guard !self.name.isEmpty else { self.showAlert(.noName); return }
            guard !self.type.isEmpty else { self.showAlert(.noType); return }
            guard !self.amount.isEmpty else { self.showAlert(.noAmount); return }
            guard let amount = Double(self.amount) else { self.showAlert(.amountNotANumber); return }
            let expense = Expense(name: self.name, type: self.type, amount: amount)
            self.expenses.items.append(expense)
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
    // MARK: Content body
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.decimalPad)
            }.navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: saveButton)
            .alert(isPresented: $alertIsShowing) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Okay")))
            }
        }
    }
    
    // MARK: Methods
    private func showAlert(_ reason: AlertReason) {
        switch reason {
        case .noName, .noType, .noAmount:
            alertTitle = "\(reason.rawValue) must not be empty"
            alertMessage = "Please enter a(n) \(reason.rawValue.lowercased()) for your expense"
        case .amountNotANumber:
            alertTitle = "Oops that's not a number"
            alertMessage = "Please enter a number for the amount of your expense"
        }
        alertIsShowing = true
    }
}

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView(expenses: Expenses())
    }
}
