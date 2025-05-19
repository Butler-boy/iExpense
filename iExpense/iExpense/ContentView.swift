//
//  ContentView.swift
//  iExpense
//
//  Created by pina lina on 18/05/2025.
//

import SwiftUI


struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()

    @State private var showingAddExpense = false
    
    var personalExpense: [ExpenseItem] {
        expenses.items.filter { $0.type == "Personal"}
    }
    
    var businessExpense: [ExpenseItem] {
        expenses.items.filter { $0.type == "Business"}
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            
                            Text(item.type)
                        }
                        Spacer()
                        
                        if item.amount > 10 && item.amount < 100 {
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "GBP"))
                                .font(.subheadline)
                        } else if item.amount >= 100 {
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "GBP"))
                                .font(.headline)
                        } else {
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "GBP"))
                                .font(.caption)
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button ("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
