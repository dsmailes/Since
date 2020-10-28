//
//  Persistence.swift
//  Since
//
//  Created by David Smailes on 22/10/2020.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    static let weddingDatecomponents = DateComponents.init(calendar: Calendar.current, timeZone: TimeZone.current, year: 2013, month: 2, day: 16, hour: 15, minute: 0, second: 0)
    static let userCalendar = Calendar.current
    static let weddingDate = userCalendar.date(from: weddingDatecomponents)


    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = SinceEvent(context: viewContext)
            newItem.title = "Wedding"
            newItem.image = "married"
            newItem.date = weddingDate
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Since")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}