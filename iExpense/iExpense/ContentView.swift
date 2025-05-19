//
//  ContentView.swift
//  iExpense
//
//  Created by pina lina on 18/05/2025.
//

import SwiftUI

struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    let name: String
    
    var body: some View {
        Button("Dismiss") {
            dismiss()
        }
        Text("Hello \(name)")
    }
}

struct ContentView: View {
    @State private var sheetShowing = false
    
    var body: some View {
        Button("Show Sheet") {
            sheetShowing.toggle()
        }
        .sheet(isPresented: $sheetShowing) {
            SecondView(name: "liny")
        }
    }
}

#Preview {
    ContentView()
}
