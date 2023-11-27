//
//  ContentView.swift
//  Hot Prospects
//
//  Created by Vito Borghi on 26/11/2023.
//

import SwiftUI

struct ContentView: View {
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
                    Label("two", systemImage: "circle")
                }
                .tag("two")
        }
    }
}

#Preview {
    ContentView()
}
