//
//  ContentView.swift
//  Hot Prospects
//
//  Created by Vito Borghi on 26/11/2023.
//

import SwiftUI

@MainActor class User: ObservableObject {
    @Published var name = "Username123"
}

struct EditView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        TextField("name", text: $user.name)
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: User

    var body: some View {
        VStack {
            Image(systemName: "person")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(user.name)
        }
        .padding()
    }
}

struct ContentView: View {
    @StateObject private var user = User()
    var body: some View {
        VStack{
            EditView()
            DisplayView()
        }
        .environmentObject(user)
    }
}

#Preview {
    ContentView()
}
