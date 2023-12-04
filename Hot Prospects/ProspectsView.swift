//
//  ProspectsView.swift
//  Hot Prospects
//
//  Created by Vito Borghi on 29/11/2023.
//

import SwiftUI

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    @EnvironmentObject var prospects: Prospects
    
    let filter: FilterType
    
    var title: String {
        switch filter {
        case .none: return "Everyone"
        case .contacted: return "Contacted People"
        case .uncontacted: return "Uncontacted People"
        }
    }
    
    var body: some View {
        NavigationStack {
            Text("People: \(prospects.people.count)")
                .navigationTitle(title)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            let prospect = Prospect()
                            prospect.name = "Paul Hudson"
                            prospect.emailAddress = "paul@hackingwithswift.com"
                            prospects.people.append(prospect)
                        } label: {
                            Label("Scan", systemImage: "qrcode.viewfinder")
                        }
                    }
                }
        }
    }
}

#Preview {
    ProspectsView(filter: .none)
        .environmentObject(Prospects())
}
