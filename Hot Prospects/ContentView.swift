//
//  ContentView.swift
//  Hot Prospects
//
//  Created by Vito Borghi on 26/11/2023.
//

import SwiftUI


struct ContentView: View {
    @State private var backgroundColour = Color.red
    @State private var chosenOption = 1
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
                .background(backgroundColour)
            
            Text("Change colour")
                .padding()
                .contextMenu {
                    Button {
                        backgroundColour = .red
                        chosenOption = 1
                    } label: {
                        Label("Red", systemImage: chosenOption == 1 ?  "checkmark.circle.fill" : "")
                    }
                    .tag(1)
                    
                    Button{
                        backgroundColour = .green
                        chosenOption = 2
                    } label: {
                        Label("Green", systemImage: chosenOption == 2 ?  "checkmark.circle.fill" : "")
                    }
                    .tag(2)
                    
                    Button {
                        backgroundColour = .blue
                        chosenOption = 3
                    } label: {
                        Label("Blue", systemImage: chosenOption == 3 ?  "checkmark.circle.fill" : "")
                    }
                    .tag(3)
                }
        }
    }
}

#Preview {
    ContentView()
}
