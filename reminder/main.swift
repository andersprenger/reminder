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
            print("1) Scheduled")
            print("2) My Lists")
            print("3) Add List")
            print("4) Add Reminder")
            print("5) Remove List")
            print("6) Remove Reminder")
            print("7) Edit Reminder")
            print("0) Exit")
            
            
            let input = readLine() ?? "-1"
            let selection = Int(input)
            
            switch selection {
            case 0:
                return
            case 1:
                showReminders(scope: .scheduled)
            case 2:
                showMyLists()
            case 3:
                addList()
            case 4:
                addReminder()
            case 5:
                removeList()
            case 6:
                removeReminder()
            case 7:
                editReminder()
            default:
                print("Option not found, try again...")
            }
            print("")
        }
    }
    
    private enum Scope {
        case scheduled
        case today
    }
    
    private func showReminders(scope: Scope) {
        for list in myLists {
            for reminder in list.reminders {
                switch scope {
                case .scheduled:
                    if let _ = reminder.date {
                        print(reminder.title, "-", reminder.scheduledTime)
                    }
                case .today:
                    //TODO: make it work
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
        if myLists.isEmpty {
            print("There's no list to show.")
        } else {
            for list in myLists {
                print("List: ", list.title)
                for reminder in list.reminders {
                    print(_: "-", terminator: "")
                    print(reminder.title, terminator: "")
                    if let _ = reminder.date {
                        print("at: ", reminder.scheduledTime)
                    } else {
                        print("")
                    }
                    if let notes = reminder.notes {
                        print("Notes: ", notes)
                    }
                }
                print("")
            }
        }
    }
    
    func addReminder() {
        if let index = selectListIndex() {
            print("Write the reminder's title:")
            let title = readLine() ?? "_DEFAULT_TITLE_"
            myLists[index].reminders.append(Reminder(title: title, notes: nil, date: nil))
            print("Reminder created!")
        }
    }
    
    func removeReminder() {
        if let listIndex = selectListIndex(){
            if let reminderIndex = selectReminderIndex(list: listIndex) {
                let temp = myLists[listIndex].reminders.remove(at: reminderIndex)
                print("Removed: ", temp.title)
            }
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
            let removedList = myLists.remove(at: index)
            print(_: "List removed:", removedList.title)
        } else {
            print("It's not possible to find the list.")
        }
    }
    
    mutating func editReminder() {
        if let listIndex = selectListIndex(){
            if let reminderIndex = selectReminderIndex(list: listIndex) {
                let reminderPosition: (Int, Int) = (listIndex, reminderIndex)
                while true {
                    print("1) Change title")
                    print("2) Change note")
                    print("3) Change date")
                    print("4) Change time")
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
                        default:
                            print("Option not found, try again...")
                    }
                }
            } else {
                print("It's not possible to find this reminder.")
            }
        } else {
            print("It's not possible to find this list.")
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
            print("It's not possible to set to this note.")
        }
    }
    
    private func changeReminderDate(reminder index: (ofList: Int, ofReminder: Int)) {
        print("Write reminder's new day:")
        let changedDay = readLine() ?? ""
        
        print("Write reminder's new month:")
        let changedMonth = readLine() ?? ""
        
        print("Write reminder's new year:")
        let changedYear = readLine() ?? ""
        
        if let intDay = Int(changedDay), let intMonth = Int(changedMonth), let intYear = Int(changedYear) {
            myLists[index.ofList].reminders[index.ofReminder].setDate(year: intYear, month: intMonth, day: intDay)
        } else {
            print("It's not possible to set to this time.")
        }
    }
    
    private func changeReminderTime(reminder index: (ofList: Int, ofReminder: Int)) {
        print("Write a hour:")
        let changedHour = readLine() ?? ""
        
        print("Write a minute:")
        let changedMinute = readLine() ?? ""
        
        if let intHour = Int(changedHour), let intMinute = Int(changedMinute) {
            myLists[index.ofList].reminders[index.ofReminder].setTime(hour: intHour, minute: intMinute)
        } else {
            print("It's not possible to set to this time.")
        }
    }
    
    private func selectReminderIndex(list index: Int) -> Int? {
        if myLists.isEmpty || index >= myLists.count || myLists[index].reminders.isEmpty { //MARK: --THIS ORDER MATTERS!
            return nil
        } else {
            print("Digit the number in the reminder's side to select it:")
            
            var count = 1 //MARK: --START WITH 1, BUT ARRAYS BEGIN WITH 0. THEN, WILL BE SUBTRACTED 1 BELLOW TO MATCH TO THE INDEX.
            for reminder in myLists[index].reminders {
                print(count, reminder.title)
                count += 1
            }
            var informedIndex = Int(readLine() ?? "-1") ?? -1
            informedIndex -= 1 //MARK: --SUBTRACTING 1 TO MATCH WITH THE INDEX.
            
            return (informedIndex >= 0 && informedIndex < myLists[index].reminders.count) ? informedIndex : nil
        }
    }
    
    private func selectListIndex() -> Int? {
        if myLists.isEmpty {
            print("There's no list to show.")
            return nil
        } else {
            print("Digit the number in the list's side to select it:")
            
            var count = 1 //MARK: --START WITH 1, BUT ARRAYS BEGIN WITH 0. THEN, WILL BE SUBTRACTED 1 BELLOW TO MATCH TO THE INDEX.
            for list in myLists {
                print(count, list.title)
                count += 1
            }
            var informedIndex = Int(readLine() ?? "-1") ?? -1
            informedIndex -= 1 //MARK: --SUBTRACTING 1 TO MATCH WITH THE INDEX.
            
            return (informedIndex >= 0 && informedIndex < myLists.count) ? informedIndex : nil
        }
    }
}

//MARK: --Running the app...
var run = Main()
run.main()
