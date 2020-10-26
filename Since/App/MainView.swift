//
//  MainView.swift
//  Since
//
//  Created by David Smailes on 22/10/2020.
//

import SwiftUI

struct MainView: View {
    
    let persistenceController = PersistenceController.shared
    
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Text("List")
                    Image(systemName: "list.bullet")
                }
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            WidgetSettingsView()
                .tabItem {
                    Text("Widget")
                    Image(systemName: "macwindow")
                }
            SettingsView()
                .tabItem {
                    Text("Settings")
                    Image(systemName: "hammer")
                }
        } // tabview
        
    }
}

struct MainView_Previews: PreviewProvider {
    
    let persistenceController = PersistenceController.shared
    
    static var previews: some View {
        MainView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
