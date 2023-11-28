//
//  ContentView.swift
//  Hot Prospects
//
//  Created by Vito Borghi on 26/11/2023.
//

import SwiftUI

@MainActor class DelayedUpdater: ObservableObject {
    var value = 0 {
        willSet {
            objectWillChange.send()
        }
    }
    
    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now()+Double(i)) {
                self.value += 1
            }
        }
    }
}

struct ContentView: View {
    @StateObject private var updater = DelayedUpdater()
    @State private var selectedTab = "one"
    var body: some View {
        TabView {
            Text("Tab 1")
                .onTapGesture {
                    selectedTab = "two"
                }
                .tabItem {
                    Label("one", systemImage: "star")
                }
            Text("Tab 2")
                .tabItem {
                    Text("Value is \(updater.value)")
                }
                .tag("two")
        }
    }
}

#Preview {
    ContentView()
}
