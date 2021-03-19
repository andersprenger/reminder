//
//  models.swift
//  reminder
//
//  Created by Anderson Sprenger, Hojin Ryu on 18/03/21.
//

import Foundation

//enum Priority {
//    case low
//    case medium
//    case high
//}



// MARK: --What do you think of this enum?
enum Repeat {
    case not
    case day
    case week
    case month
    case year
}

struct Reminder {
    var title: String
    var notes: String?
    var date: DateComponents?
    var scheduledTime: String {
        "\(date?.day ?? 0)/\(date?.month ?? 0)/\(date?.year ?? 0) \(date?.hour ?? 0):\(date?.minute ?? 0)"
    }
    //TODO: var priority: Priority?
    //TODO: var repeat: Repeat
    //TODO: var location: String?
    
    mutating func setDate(year: Int, month: Int, day: Int, hour: Int, minute: Int) {
        var temp = DateComponents()
        
        temp.calendar = .current
        temp.year = year
        temp.month = month
        temp.day = day
        temp.hour = hour
        temp.minute = minute
        
        self.date = temp
    }
    
}

class List {
    var title: String
    var reminders: [Reminder]
    var whoami: String {
        return ""//TODO: this
    }
    
    
    init(title: String) {
        self.title = title
        reminders = []
    }
}
