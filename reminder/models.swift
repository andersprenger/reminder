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
        //"\(date?.day ?? 0)/\(date?.month ?? 0)/\(date?.year ?? 0) \(date?.hour ?? 0):\(date?.minute ?? 0)"
        var str: String = ""
        if let tempDay = date?.day, let tempMonth = date?.month, let tempYear = date?.year {
            if tempDay < 10{
                str += "0"
                str += String(tempDay)
            } else {
                str += String(tempDay)
            }
            str += "/"
            if tempMonth < 10{
                str += "0"
                str += String(tempMonth)
            } else {
                str += String(tempMonth)
            }
            str += "/"
            if tempYear < 10{
                str += "0"
                str += String(tempYear)
            } else {
                str += String(tempYear)
            }
            str += " "
        }
        if let tempHour = date?.hour, let tempMinute = date?.minute {
            if tempHour < 10{
                str += "0"
                str += String(tempHour)
            } else {
                str += String(tempHour)
            }
            str += ":"
            if tempMinute < 10{
                str += "0"
                str += String(tempMinute)
            } else {
                str += String(tempMinute)
            }
        }
        
        return str
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
