//
//  ContentView.swift
//  Hot Prospects
//
//  Created by Vito Borghi on 26/11/2023.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Query var prospects: [Prospect]
    var body: some View {
        ZStack{
            LinearGradient(colors: [.black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            TabView {
                ProspectsView(filter: .none)
                    .tabItem {
                        Label("Everyone", systemImage: "person.3")
                    }
                
                ProspectsView(filter: .contacted)
                    .tabItem {
                        Label("Contacted", systemImage: "checkmark.circle")
                    }
                
                ProspectsView(filter: .uncontacted)
                    .tabItem {
                        Label("Uncontacted", systemImage: "questionmark.diamond")
                    }
                
                MeView()
                    .tabItem {
                        Label("Me", systemImage: "person.crop.square")
                    }
            }
            //.environmentObject(prospects)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Prospect.self)
}
