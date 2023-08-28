//
//  HomeViewController.swift
//  task2_app
//
//  Created by Murat Can ASLAN on 28.08.2023.
//

import UIKit
import UserNotifications

final class HomeViewController: UIViewController {

    @IBOutlet private weak var timePicker: UIDatePicker!
    
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.requestNotification(delegate: self)
        
        setupTimePicker()
    }
    
    private func setupTimePicker() {
        timePicker.locale = Locale.current
    }
    
    @IBAction private func didTapSetAlarm(_ sender: UIButton) {
        let date = timePicker.date
        showMessage(message: "Create alarm on \(date.timeString()) successfully")
        scheduleLocalNotification(at: date)
        
    }
    
    func scheduleLocalNotification(at date: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Alarm!"
        content.body = "Wake up!"
        if let soundURL = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") {
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: soundURL.lastPathComponent))
        } else {
            // Default sound
            content.sound = UNNotificationSound.default
        }
        var calendar = Calendar.current
        calendar.locale = Locale.current
        let components = calendar.dateComponents([.hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let request = UNNotificationRequest(identifier: "alarm", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            } else {
                print("Notification scheduled successfully!")
            }
        }
    }
}



extension HomeViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        SoundManager.shared.playAlarmSound()
        if response.actionIdentifier == UNNotificationDefaultActionIdentifier {
            
            showMessage(message: "Do you want to stop alarm music?", action: .init(title: "Stop", style: .default, handler: { _ in
                SoundManager.shared.stopAlarmSound()
            }))
            
        }
        completionHandler()
    }
}
