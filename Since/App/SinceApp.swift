//
//  SinceApp.swift
//  Since
//
//  Created by David Smailes on 22/10/2020.
//

import SwiftUI
import StoreKit

@main
struct SinceApp: App {
    
    let persistenceController = PersistenceController.shared
    
    @StateObject var storeManager = StoreManager()
    
    var body: some Scene {
        WindowGroup {
            //display the splashview then show the main application window
            SplashView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear(perform: {
                    UIApplication.shared.addTapGestureRecognizer()
                    SKPaymentQueue.default().add(storeManager)
                })
        }
    }
}
