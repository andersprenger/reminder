//
//  models.swift
//  reminder
//
//  Created by Anderson Sprenger, Hojin Ryu on 18/03/21.
//

import Foundation

enum Priority {
    case low
    case medium
    case high
}

struct Reminder {
    var title: String
    var notes: String?
    var date: DateComponents?
    var priority: Priority?
    var scheduledTime: String {
        "\(date?.day ?? 0)/\(date?.month ?? 0)/\(date?.year ?? 0) \(date?.hour ?? 0):\(date?.minute ?? 0)"
    }
    
    mutating func setDate(year: Int, month: Int, day: Int) {
        if var temp = date {
            temp.calendar = .current
            temp.year = year
            temp.month = month
            temp.day = day
            
            self.date = temp
        } else {
            var temp = DateComponents()
            temp.calendar = .current
            temp.year = year
            temp.month = month
            temp.day = day
            
            self.date = temp
        }
    }
    
    mutating func setTime(hour: Int, minute: Int) {
        if var temp = date {
            temp.calendar = .current
            temp.hour = hour
            temp.minute = minute
            
            self.date = temp
        } else {
            var temp = DateComponents()
            temp.calendar = .current
            temp.hour = hour
            temp.minute = minute
            
            self.date = temp
        }
    }
}

class List {
    var title: String
    var reminders: [Reminder]
    
    init(title: String) {
        self.title = title
        reminders = []
    }
}
