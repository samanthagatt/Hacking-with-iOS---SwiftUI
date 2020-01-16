//
//  ContentView.swift
//  iExpense
//
//  Created by Samantha Gatt on 1/16/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: Observed properties
    @ObservedObject var expenses = Expenses()
    
    // MARK: Subviews
    private var addButton: some View {
        Button(action: {
            let expenseItem = ExpenseItem(name: "Testing", type: "Personal", amount: 5)
            self.expenses.items.append(expenseItem)
        }) {
            Image(systemName: "plus")
        }
    }
    
    // MARK: Content body
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    Text(item.name)
                }.onDelete(perform: removeExpenseItems(at:))
            }.navigationBarTitle("iExpense")
            .navigationBarItems(trailing: addButton)
        }
    }
    
    // MARK: Methods
    private func removeExpenseItems(at offsets: IndexSet) {
        self.expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
