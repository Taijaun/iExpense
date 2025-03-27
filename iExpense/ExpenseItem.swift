//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Taijaun Pitt on 27/03/2025.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    
    let name: String
    let type: String
    let amount: Double
}

// Collection of expenseItems, including a currency Code
@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    var currencyCode: String {
        get { UserDefaults.standard.string(forKey: "CurrencyCode") ?? "GBP" }
        set { UserDefaults.standard.set(newValue, forKey: "CurrencyCode") }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems){
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}
