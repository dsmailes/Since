//
//  WidgetSettingsView.swift
//  Since
//
//  Created by David Smailes on 22/10/2020.
//

import SwiftUI
import CoreData

struct WidgetSettingsView: View {
    
    @State private var showingAddEventView: Bool = false
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \SinceEvent.date, ascending: true)],
        animation: .default)
    
    private var events: FetchedResults<SinceEvent>
    
    @AppStorage("widgetData", store: UserDefaults(suiteName: "group.com.mylearningapps.since")) var widgetData: SinceEvent
    
    var body: some View {
        NavigationView {
            ZStack{
                List {
                    ForEach(self.events, id: \.self) { item in
                        SinceItemListView(event: item)
                            .onTapGesture {
                                print(item)
                                widgetData = item
                            }
                    }
                    
                } // List
                .navigationBarTitle("Widget selection...", displayMode: .large)
                .listStyle(InsetListStyle())
            } // zstack
            .sheet(isPresented: $showingAddEventView) {
                AddEventView().environment(\.managedObjectContext, self.viewContext)
            }
        }
    }
}

struct WidgetSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetSettingsView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
