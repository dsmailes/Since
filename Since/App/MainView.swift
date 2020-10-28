//
//  MainView.swift
//  Since
//
//  Created by David Smailes on 22/10/2020.
//

import SwiftUI

struct MainView: View {
    
    let persistenceController = PersistenceController.shared
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        TabView() {
            
            ContentView(addEventViewPresented: false)
                .tabItem {
                    Text("List")
                    Image(systemName: "list.bullet")
                }
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .tag(0)
            
            WidgetSettingsView()
                .tabItem {
                    Text("Widget")
                    Image(systemName: "macwindow")
                }
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .tag(2)
    
        } // tabview
    
    }
}

struct MainView_Previews: PreviewProvider {
    
    let persistenceController = PersistenceController.shared
    
    static var previews: some View {
        MainView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
