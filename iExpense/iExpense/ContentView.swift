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
    
    // MARK: State properties
    @State private var addExpenseIsShowing = false
    
    // MARK: Subviews
    private var addButton: some View {
        Button(action: {
            self.addExpenseIsShowing = true
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
                }.onDelete(perform: removeExpenses(at:))
            }.navigationBarTitle("iExpense")
            .navigationBarItems(trailing: addButton)
                .sheet(isPresented: $addExpenseIsShowing) {
                    AddExpenseView(expenses: self.expenses)
            }
        }
    }
    
    // MARK: Methods
    private func removeExpenses(at offsets: IndexSet) {
        self.expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
