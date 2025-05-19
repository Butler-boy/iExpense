//
//  ContentView.swift
//  iExpense
//
//  Created by pina lina on 18/05/2025.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("TapCount") private var tapCount = 0
    
    var body: some View {
        Button("Tap Count \(tapCount)") {
            tapCount += 1
        }
    }
}

#Preview {
    ContentView()
}
