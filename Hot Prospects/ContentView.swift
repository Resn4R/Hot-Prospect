//
//  ContentView.swift
//  Hot Prospects
//
//  Created by Vito Borghi on 26/11/2023.
//

import SwiftUI
import UserNotifications
import SamplePackage

struct ContentView: View {
    let possibleNumber = Array(1...60)
    var results: String {
        let selected = possibleNumber.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }
    
    var body: some View {
        VStack{
            
            Text(results)
            
            Spacer()
            Button("Request Permision") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print ("all set")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
            .padding()
            
            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "feed the dogs"
                content.subtitle = "they look hungry"
                content.sound = UNNotificationSound.default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
}

#Preview {
    ContentView()
}
