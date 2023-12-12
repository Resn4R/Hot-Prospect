//
//  ProspectsView.swift
//  Hot Prospects
//
//  Created by Vito Borghi on 29/11/2023.
//

import SwiftData
import CodeScanner
import SwiftUI
import UserNotifications

enum FilterType {
       case none, contacted, uncontacted
   }

struct ProspectsView: View {
    
   
    let filter: FilterType
    
    @Environment(\.modelContext) var modelContext
    @Query var prospects: [Prospect]
    
    @State private var isShowingScanner = false
    @State private var isShowingConfirmationDialog = false
    
    @State private var sortOrder = SortDescriptor(\Prospect.name)

    var title: String {
        switch filter {
        case .none: return "Everyone"
        case .contacted: return "Contacted People"
        case .uncontacted: return "Uncontacted People"
        }
    }
    
    var body: some View {
        NavigationStack {
            
            ProspectListingView(sort: sortOrder, filter: filter)
            
            .navigationTitle(title)
            .confirmationDialog("Sort Elements by", isPresented: $isShowingConfirmationDialog) {
                Button("Name") {
                    sortOrder = SortDescriptor(\Prospect.name)
                }
                Button("Email"){
                    sortOrder = SortDescriptor(\Prospect.emailAddress)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isShowingScanner = true
                    } label: {
                        Label("Scan", systemImage: "qrcode.viewfinder")
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button{
                        isShowingConfirmationDialog.toggle()
                    } label: {
                        Image(systemName: "list.bullet")
                    }
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: handleScan)
            }
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: .newlines)
            guard details.count == 2 else { return }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            modelContext.insert(person)
        case .failure(let error):
            print("Scanning Failed: \(error.localizedDescription)")
        }
    }
    
    
}

#Preview {
    ProspectsView(filter: .none)
        .modelContainer(for: Prospect.self)
}
