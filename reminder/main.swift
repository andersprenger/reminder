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
            print("7) Remove Reminder")
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
                    addReminder()
                case 5:
                    addList()
                case 6:
                    removeList()
                case 7:
                    removeReminder()
                default:
                    print("Option not found, try again...")
                }
        }
    }
    
    //Date.init() creates a date value initialized to the current date and time.
    //TODO: Extract part of those functions that are similar, to another function.
    func showToday() {
        for list in myLists {
            for reminder in list.reminders {
                if let _ = reminder.date {
                    let date = Date.init()
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateStyle = .short
                    dateFormatter.timeStyle = .short
                    
                    if reminder.scheduledTime == dateFormatter.string(from: date){
                        print()
                    }
                    
                }
            }
        }
    }
    //TODO: Extract part of those functions that are similar, to another function. //using enum
    
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
    
    //terminar
    func addReminder() {
        if let index = selectListIndex() {
            print("Inform the title:")
            print()
            let reminder: Reminder = Reminder(title: <#T##String#>)
            myLists[index].reminders.
        }
    }
    
    mutating func addList() {
        print("Write the title:")
        if let newTitle = readLine() {
            let newList = List(title: newTitle)
            myLists.append(newList)
        } else {
            print("It's not possible to read the title informed.")
        }
    }
    
    mutating func removeList() {
        if let index = selectListIndex() {
            print(_: "Removed:", myLists.remove(at: index), separator: "\n", terminator: "\n")
        } else {
            print("It's not possible to find the list.")
        }
    }
    
    func editReminder() {
        //TODO: Write logic.
    }
    
    func removeReminder() {
        //TODO: Write logic.
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
