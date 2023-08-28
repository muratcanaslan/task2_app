//
//  Date+Ext.swift
//  task2_app
//
//  Created by Murat Can ASLAN on 28.08.2023.
//

import Foundation

extension Date {
    func timeString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
}
