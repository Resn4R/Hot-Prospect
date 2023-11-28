//
//  ContentView.swift
//  Hot Prospects
//
//  Created by Vito Borghi on 26/11/2023.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        List{
            Text("Test List")
                .swipeActions {
                    Button{
                        print("hello")
                    } label: {
                        Label("Send Message", systemImage: "message")
                    }
                    Button(role: .destructive) {
                        print("deleting...")
                    } label: {
                        Label("Deleting", systemImage: "minus.circle")
                    }
                }
                .swipeActions(edge: .leading) {
                    Button {
                        print("Pinning")
                    } label: {
                        Label("Pin", image: "pin")
                    }
                    .tint(.orange)
                }
        }
    }
}

#Preview {
    ContentView()
}
