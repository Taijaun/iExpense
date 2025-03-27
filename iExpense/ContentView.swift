//
//  ContentView.swift
//  iExpense
//
//  Created by Taijaun Pitt on 01/03/2025.
//

import SwiftUI
import Observation

// Single expense item




struct ContentView: View {
    @State private var expenses = Expenses()
    //@State private var showingAddExpense = false
    
    let currencyOptions = ["GBP", "USD", "EUR", "AUD", "CAD", "JPY"]
    
    //Filter the expenses by their type
    var personalExpenses: [ExpenseItem] {
        expenses.items.filter { $0.type == "Personal" }
    }
    
    var businessExpenses: [ExpenseItem] {
        expenses.items.filter { $0.type == "Business" }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Picker("Currency", selection: $expenses.currencyCode) {
                    ForEach(currencyOptions, id:\.self){ currency in
                        Text(currency)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
            }
            List {
                // Personal Expenses
                Section(header: Text("Personal Expenses")) {
                    ForEach(personalExpenses) { expense in
                        expenseRow(for: expense)
                    }
                    .onDelete { indexSet in removeItems(at: indexSet, from: personalExpenses)}
                }
                
                    // Business Expenses
                    Section(header: Text("Business Expenses")){
                        ForEach(businessExpenses) { expense in
                            expenseRow(for: expense)
                        }
                        .onDelete { indexSet in removeItems(at: indexSet, from: businessExpenses)}
                    }
                }
                .navigationTitle("iExpense")
//                .sheet(isPresented: $showingAddExpense) {
//                    // show addview here
//                    AddView(expenses: expenses)
            
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink(destination: AddView(expenses: expenses)) {
                            Image(systemName: "plus")
                        }
                }
                
                
            }
                }
                
        }
    func expenseRow(for item: ExpenseItem) -> some View {
        HStack{
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.title3)
                Text(item.type)
                    .font(.headline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text(item.amount, format: .currency(code: expenses.currencyCode))
                .foregroundStyle(item.amount < 10 ? .green : item.amount < 100 ? .orange : .red)
        }
    }
    func removeItems(at offsets: IndexSet, from list: [ExpenseItem]) {
        let itemsToRemove = offsets.map { list[$0].id }
        expenses.items.removeAll { itemsToRemove.contains($0.id) }
    }
    }
        
        

#Preview {
    ContentView()
}
