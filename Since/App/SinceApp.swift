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
            SplashView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        }
    }
}
