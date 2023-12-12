//
//  ProspectListingView.swift
//  Hot Prospects
//
//  Created by Vito Borghi on 12/12/2023.
//

import SwiftData
import SwiftUI

struct ProspectListingView: View {
    
    
    @Query var prospects: [Prospect]
    
    let filter: FilterType
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.filter{ !$0.isSelf }
        case .contacted:
            return prospects.filter{ !$0.isSelf }.filter{ $0.isConnected }
        case .uncontacted:
            return prospects.filter{ !$0.isSelf }.filter{ !$0.isConnected }
        }
    }


    init(sort: SortDescriptor<Prospect>, filter: FilterType) {
        _prospects = Query(sort: [sort])
        self.filter = filter
    }
    
    var body: some View {
        List {
            ForEach(filteredProspects) { prospect in
                VStack(alignment: .leading) {
                    Label(prospect.name, systemImage: showLabel(of: prospect) )
                        .font(.headline)
                    Text(prospect.emailAddress)
                        .foregroundStyle(.secondary)
                }
                .swipeActions {
                    if prospect.isConnected {
                        Button {
                            prospect.toggleContacted()
                        } label: {
                            Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
                        }
                        .tint(.blue)
                    } else {
                        Button {
                            prospect.toggleContacted()
                        } label: {
                            Label("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
                        }
                        .tint(.green)
                        
                        Button {
                            addNotification(for: prospect)
                        } label: {
                            Label("Remind Me", systemImage: "bell")
                        }
                        .tint(.orange)
                    }
                }
            }
        }
    }
    
    func showLabel(of prospect: Prospect) -> String {
        prospect.isConnected ? "person.crop.circle.fill.badge.checkmark" : "person.crop.circle.badge.xmark"
    }

    func addNotification(for prospect: Prospect) {
        let centre = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            var dateComponent = DateComponents()
            dateComponent.hour = 9
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            centre.add(request)
        }
        
        centre.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                centre.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("error.")
                    }
                }
            }
        }
    }

}

#Preview {
    ProspectListingView(sort: SortDescriptor(\Prospect.name), filter: .none)
        .modelContainer(for: Prospect.self)
}
