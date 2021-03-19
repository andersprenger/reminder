//
//  main.swift
//  reminder
//
//  Created by Anderson Sprenger, Hojin Ryu on 18/03/21.
//

import Foundation

struct Main {
    var myLists: [List]
    var local: Locale
    
    init() {
        myLists = []
        local = Locale.current
    }
    
    mutating func main() {
        print("Reminder")
        while true {
            print("Digit an option:")
            print("1) Today")
            print("2) Scheduled")
            print("3) My Lists")
            print("4) Add List")
            print("5) Add Reminder")
            print("6) Remove List")
            print("7) edit Reminder")
            print("0) Exit")
            
            
            let input = readLine() ?? "-1"
            let selection = Int(input)
            
            switch selection {
                case 0:
                    return
                case 1:
                    showReminders(scope: .today)
                case 2:
                    showReminders(scope: .scheduled)
                case 3:
                    showMyLists()
                case 4:
                    addList()
                case 5:
                    addReminder()
                case 6:
                    removeList()
                case 7:
                    editReminder()
                default:
                    print("Option not found, try again...")
                }
        }
    }
    
    //TODO: understand the date thing...
    func showToday() {
        for list in myLists {
            for reminder in list.reminders {
                if let _ = reminder.date {
                    let date = Date.init()
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateStyle = .short
                    dateFormatter.timeStyle = .short
                    
                    if reminder.scheduledTime == dateFormatter.string(from: date){
                        print(reminder)
                    }
                }
            }
        }
    }
    
    private enum Scope {
        case scheduled
        case today
    }
    
    private mutating func showReminders(scope: Scope) {
        for list in myLists {
            for reminder in list.reminders {
                switch scope {
                case .scheduled:
                    if let _ = reminder.date {
                        print(reminder.scheduledTime)
                    }
                case .today:
                    if let _ = reminder.date {
                        let date = Date.init()
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateStyle = .short
                        dateFormatter.timeStyle = .short
                        
                        if reminder.scheduledTime == dateFormatter.string(from: date){
                            print(reminder.scheduledTime)
                        }
                        
                    }
                }
            }
        }
    }
    
    
    func showMyLists() {
        for list in myLists {
            print(list.title)
            //TODO: select list and show reminders inside the list...
        }
    }
    
    func addReminder() {
        if let index = selectListIndex() {
            print("Write the reminder's title:")
            let title = readLine() ?? "_DEFAULT_TITLE_"
            myLists[index].reminders.append(Reminder(title: title, notes: nil, date: nil))
            print("Remind created!")
        }
    }
    
    mutating func addList() {
        print("Write the list's title:")
        if let newTitle = readLine() {
            let newList = List(title: newTitle)
            myLists.append(newList)
            print("List created!")
        } else {
            print("It's not possible to read the title informed.")
        }
    }
    
    mutating func removeList() {
        if let index = selectListIndex() {
            print(_: "Reminder removed:", myLists.remove(at: index).title, separator: "\n", terminator: "\n")
        } else {
            print("It's not possible to find the list.")
        }
    }
    
    mutating func editReminder() {
        if let listIndex = selectListIndex(){
            let reminderPosition = selectReminderIndex(list: listIndex)
            print("1) Change title")
            print("2) Change note")
            print("3) Change date or time")
            
            //TODO: print("4) Change priority") print("5) Change repeat") print("6) Change location")
            let input = readLine() ?? "-1"
            let choice = Int(input)
            
            switch choice {
                case 0:
                    return
                case 1:
                   changeReminderTitle()
                case 2:
                    ch
                case 3:
                    

                    
                default:
                    print("Option not found, try again...")
                }
        }
    }
    
    private func changeReminderTitle() {
        print("Write the title: ")
        let name = readLine() ?? ""
        
        myLists[listIndex].reminders[reminderPosition].title = name
    }
    
    private func changeReminderNote() {
        print("Write the description")
        let description = readLine() ?? ""
        
        myLists[listIndex].reminders[reminderPosition].notes = description
    }
    
    private func changeReminderDate() {
        print("Print day!")
        let changedDay = readLine() ?? ""
        let intDay = Int(changedDay) ?? 0
        
        print("Print month!")
        let changedMonth = readLine() ?? ""
        let intMonth = Int(changedMonth) ?? 0
        
        print("Print year!")
        let changedYear = readLine() ?? ""
        let intYear = Int(changedYear) ?? 0
    }
    
    private func changeReminderTime() {
        print("Do you want to edit time?")
        print("1- Yes")
        print("2- No")
        let changedTime = readLine() ?? ""
        let intTime = Int(changedTime) ?? 0
        
        switch intTime {
            case 1:
                print("Print hour!")
                let changedHour = readLine() ?? ""
                let intHour = Int(changedHour) ?? 0
                
                print("Print minute!")
                let changedMinute = readLine() ?? ""
                let intMinute = Int(changedMinute) ?? 0
                
                myLists[listIndex].reminders[reminderPosition].setDate(year: intYear, month: intMonth, day: intDay, hour: intHour, minute: intMinute)
                
            case 2:
                myLists[listIndex].reminders[reminderPosition].setDate(year: intYear, month: intMonth, day: intDay, hour: 0, minute: 0)
                
            default:
                print("Option not found, try again...")
        }
    }
    
    func removeReminder() {
        //TODO: Write logic.
    }
    
    mutating func selectReminderIndex(list index: Int) -> Int? {
        if myLists[index].reminders.isEmpty {
            return nil
        } else {
            
        }
    }
    
    private func selectListIndex() -> Int? {
        if myLists.isEmpty {
            print("There's no list to show.")
            return nil
        } else {
            var count = 0
            for list in myLists {
                print(count, list)
                count += 1
            }
            print("Digit the number in the list's side to select it:")
            let index = Int(readLine() ?? "-1") ?? -1
            return (index >= 0 && index <= myLists.count) ? index : nil
        }
    }
}

//MARK: --Running the app...
var run = Main()
run.main()
