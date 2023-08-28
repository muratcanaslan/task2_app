//
//  HomeViewModel.swift
//  task2_app
//
//  Created by Murat Can ASLAN on 28.08.2023.
//

import Foundation
import UserNotifications

final class HomeViewModel {
        
    func requestNotification(delegate: UNUserNotificationCenterDelegate) {
        let center = UNUserNotificationCenter.current()
        center.delegate = delegate
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            self.grantedNotif = ((error == nil) && granted)
        }
    }
}
