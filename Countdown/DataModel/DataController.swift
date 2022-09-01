//
//  DataController.swift
//  Countdown
//
//  Created by MAA on 31.08.2022.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "ActivityModel")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved!!!")
        } catch {
            print("We could not save the data...")
        }
    }
    
    func addActivity(name: String, title: String, date: Date, context: NSManagedObjectContext) {
        let activity = Activity(context: context)
        activity.id = UUID()
        activity.name = name
        activity.title = title
        activity.date = date
        
        save(context: context)
    }
    
    func editActivity(activity: Activity, name: String, title: String, date: Date, context: NSManagedObjectContext) {
        activity.name = name
        activity.title = title
        activity.date = date
        
        save(context: context)
    }
}
