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
                    
                
                
                    
                    
            } // tabview
            .transition(.slide)
            .animation(.easeInOut)
        
    }
}

struct MainView_Previews: PreviewProvider {
    
    let persistenceController = PersistenceController.shared
    
    static var previews: some View {
        MainView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
