//
//  main.swift
//  reminder
//
//  Created by Anderson Sprenger, Hojin Ryu on 18/03/21.
//

import Foundation

struct Main {
    var myLists: [List]
    
    init() {
        myLists = []
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
    
    private enum Scope {
        case scheduled
        case today
    }
    
    //TODO: Understand what is happening with dateFormater...
    private func showReminders(scope: Scope) {
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
    
    
    //TODO: select list and show reminders inside the list...
    func showMyLists() {
        for list in myLists {
            print(list.title)
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
        if let listIndex = selectListIndex(), let reminderIndex = selectReminderIndex(list: listIndex) {
            let reminderPosition: (Int, Int) = (listIndex, reminderIndex)
            print("1) Change title")
            print("2) Change note")
            print("3) Change date")
            print("4) Change time")
            print("5) Change priority")
            print("0) Exit")
            
            let input = readLine() ?? "-1"
            let choice = Int(input)
            
            switch choice {
            case 0:
                return
            case 1:
                changeReminderTitle(reminder: reminderPosition)
            case 2:
                changeReminderNote(reminder: reminderPosition)
            case 3:
                changeReminderDate(reminder: reminderPosition)
            case 4:
                changeReminderTime(reminder: reminderPosition)
            case 5:
                changeReminderPriority(reminder: reminderPosition)
            default:
                print("Option not found, try again...")
            }
        }
    }
    
    private func changeReminderTitle(reminder index: (ofList: Int, ofReminder: Int)) {
        print("Write the reminder's new title:")
        if let newTitle = readLine() {
            myLists[index.ofList].reminders[index.ofReminder].title = newTitle
        } else {
            print("It's not possible to change to this title.")
        }
    }
    
    private func changeReminderNote(reminder index: (ofList: Int, ofReminder: Int)) {
        print("Write the reminder's note:")
        if let description = readLine() {
            myLists[index.ofList].reminders[index.ofReminder].notes = description
        } else {
            print("It's not possible to set this note.")
        }
    }
    
    private func changeReminderDate(reminder index: (ofList: Int, ofReminder: Int)) {
        print("Write reminder's new day, in format DD:")
        let changedDay = readLine() ?? ""
        let intDay = Int(changedDay) ?? 0
        
        print("Write reminder's new day, in format DD:")
        let changedMonth = readLine() ?? ""
        let intMonth = Int(changedMonth) ?? 0
        
        print("Write reminder's new day, in format DD:")
        let changedYear = readLine() ?? ""
        let intYear = Int(changedYear) ?? 0
    }
    
    private func changeReminderTime(reminder index: (ofList: Int, ofReminder: Int)) {
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
            
            myLists[index.ofList].reminders[index.ofReminder].setDate
            
        case 2:
            myLists[index.ofList].reminders[index.ofReminder].setDate
            
        default:
            print("Option not found, try again...")
        }
    }
    
    private func changeReminderPriority(reminder index: (ofList: Int, ofReminder: Int)) {
        //TODO: Write logic.
    }
    
    func removeReminder() {
        //TODO: Write logic.
    }
    
    private func selectReminderIndex(list index: Int) -> Int? {
        if myLists.isEmpty || index < myLists.count || myLists[index].reminders.isEmpty { //MARK: --THIS ORDER MATTERS!
            return nil
        } else {
            var count = 1 //MARK: --START WITH 1, BUT ARRAYS BEGIN WITH 0. THEN, WILL BE SUBTRACTED 1 BELLOW TO MATCH TO THE INDEX.
            for reminder in myLists[index].reminders {
                print(count, reminder.title)
                count += 1
            }
            print("Digit the number in the reminder's side to select it:")
            var informedIndex = Int(readLine() ?? "-1") ?? -1
            informedIndex -= 1 //MARK: --SUBTRACTING 1 TO MATCH WITH THE INDEX.
            return (informedIndex >= 0 && informedIndex <= myLists[index].reminders.count) ? informedIndex : nil
        }
    }
    
    private func selectListIndex() -> Int? {
        if myLists.isEmpty {
            print("There's no list to show.")
            return nil
        } else {
            var count = 1 //MARK: --START WITH 1, BUT ARRAYS BEGIN WITH 0. THEN, WILL BE SUBTRACTED 1 BELLOW TO MATCH TO THE INDEX.
            for list in myLists {
                print(count, list)
                count += 1
            }
            print("Digit the number in the list's side to select it:")
            var informedIndex = Int(readLine() ?? "-1") ?? -1
            informedIndex -= 1 //MARK: --SUBTRACTING 1 TO MATCH WITH THE INDEX.
            return (informedIndex >= 0 && informedIndex <= myLists.count) ? informedIndex : nil
        }
    }
}

//MARK: --Running the app...
var run = Main()
run.main()
