//
//  AddView.swift
//  iExpense
//
//  Created by Taijaun Pitt on 02/03/2025.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    let types = ["Business", "Personal"]
    
    var expenses: Expenses
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type){
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .number)
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        saveExpense(name: name, type: type, amount: amount)
                        dismiss()
                    }
                }
                
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel"){
                        dismiss()
                    }
                }
            }
            .navigationBarBackButtonHidden()
        }
    }
    
    func saveExpense(name: String, type: String, amount: Double){
        let expense = ExpenseItem(name: name, type: type, amount: amount)
        expenses.items.append(expense)
    }
}

#Preview {
    AddView(expenses: Expenses())
}
