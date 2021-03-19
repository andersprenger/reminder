//
//  main.swift
//  reminder
//
//  Created by Anderson Sprenger, Hojin Ryu on 18/03/21.
//

import Foundation

struct Main {
    var lists: Array<List>
    var local: Locale
    
    init() {
        lists = Array<List>()
        local = Locale.current
    }
    
    func main() {
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
                showToday()
            case 2:
                showScheduled()
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
    
    func showToday() {
        for list in lists {
            for reminder in list.reminders {
                if reminder.date == Date.init() { //Date.init() creates a date value initialized to the current date and time.
                    print(reminder)
                }
            }
        }
    }
    
    func showScheduled() {
        //TODO: Write logic.
    }
    
    func showMyLists() {
        //TODO: Write logic.
    }
    
    func addReminder() {
        //TODO: Write logic.
    }
    
    func addList() {
        //TODO: Write logic.
    }
    
    func removeList() {
        //TODO: Write logic.
    }
    
    func removeReminder() {
        //TODO: Write logic.
    }
}

//MARK: --Running the app...
var run = Main()
run.main()
