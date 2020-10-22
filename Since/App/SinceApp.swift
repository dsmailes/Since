//
//  SinceApp.swift
//  Since
//
//  Created by David Smailes on 22/10/2020.
//

import SwiftUI

@main
struct SinceApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
