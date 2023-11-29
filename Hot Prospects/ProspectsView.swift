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
    
    let filter: FilterType
    
    var title: String {
        switch filter {
        case .none: return "Everyone"
        case .contacted: return "Contacted People"
        case .uncontacted: return "Uncontacted People"
        }
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .navigationTitle(title)
    }
}

#Preview {
    ProspectsView(filter: .none)
}
