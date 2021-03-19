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
    var notes: String
    var date: Date?
    var priority: Priority?
    //TODO: var repeat: Repeat
    //TODO: var location: String?
    
    func setDate(_: String) -> Bool {
        //TODO: a method that receives a String and converts it to date, than it sets self.date to it.
        return true
    }
    
    func toString() -> String {
        return title //TODO: improve this...
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
