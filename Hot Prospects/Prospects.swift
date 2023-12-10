//
//  Prospects.swift
//  Hot Prospects
//
//  Created by Vito Borghi on 29/11/2023.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class Prospect: Identifiable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isConnected = false
    
    init(id: UUID = UUID(), name: String = "Anonymous", emailAddress: String = "", isConnected: Bool = false) {
        self.id = id
        self.name = name
        self.emailAddress = emailAddress
        self.isConnected = isConnected
    }
    
    func toggleContacted() {
        self.isConnected.toggle()
    }
}

@MainActor class Prospects: ObservableObject {
    @Published var people: [Prospect]
    
    init() {
        self.people = []
    }
    
    func toggleContacted(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isConnected.toggle()
    }
    
}
