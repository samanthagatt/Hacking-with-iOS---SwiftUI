//
//  Expense.swift
//  iExpense
//
//  Created by Samantha Gatt on 1/16/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import Foundation

struct Expense: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Double
}

class Expenses: ObservableObject {
    /// UserDefaults key for stored items as data
    static let itemsKey = "Expense items"
    
    @Published var items: [Expense] = [] {
        didSet {
            guard let encoded = try? JSONEncoder().encode(items) else { return }
            UserDefaults.standard.set(encoded, forKey: Self.itemsKey)
        }
    }
    
    init(items: [Expense]) {
        self.items = items
    }
    init(fromUserDefaults: Bool = true) {
        if fromUserDefaults {
            guard let itemsData = UserDefaults.standard.data(forKey: Expenses.itemsKey),
                let items = try? JSONDecoder().decode([Expense].self, from: itemsData) else { return }
            self.items = items
        }
    }
}
