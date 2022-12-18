//
//  LocalNotificationManager.swift
//  RAWGVideoGames
//
//  Created by Yeliz Akkaya on 18.12.2022.
//

import Foundation
import UserNotifications

protocol NotificationProtocol {
    func sendNotification(title: String, message: String)
}

final class LocalNotificationManager: NotificationProtocol {
    static let shared = LocalNotificationManager()
    private let notificationCenter: UNUserNotificationCenter
    
    init(notificationCenter: UNUserNotificationCenter = .current()) {
        self.notificationCenter = notificationCenter
    }
    func sendNotification(title: String, message: String) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title.localized()
        notificationContent.body = message.localized()
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let request = UNNotificationRequest(identifier: "LintNotification", content: notificationContent, trigger: trigger)
        
        self.notificationCenter.add(request) { error in
            if let error = error {
                print(error)
            }
        }
    }
}
