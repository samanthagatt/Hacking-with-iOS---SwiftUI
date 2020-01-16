//
//  Expense.swift
//  iExpense
//
//  Created by Samantha Gatt on 1/16/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import Foundation

struct Expense: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    @Published var items: [Expense] = []
}
