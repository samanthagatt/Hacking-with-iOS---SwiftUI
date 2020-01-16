//
//  AddExpenseView.swift
//  iExpense
//
//  Created by Samantha Gatt on 1/16/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import SwiftUI

struct AddExpenseView: View {
    
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
    
    // MARK: Subviews
    private var saveButton: some View {
        Button("Save") {
            guard let amount = Int(self.amount) else { return }
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
                    .keyboardType(.numberPad)
            }.navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: saveButton)
        }
    }
}

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView(expenses: Expenses())
    }
}
