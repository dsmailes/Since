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
    
    var body: some View {
        NavigationView {
            ZStack{
                List {
                    ForEach(self.events, id: \.self) { item in
                        SinceItemListView(event: item)
                            .onTapGesture {
                                print(item)
                                saveWidgetData(item: item)
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
    
    func saveWidgetData(item: SinceEvent) {
        
        let widgetEvent = WidgetSinceEvent(title: item.title!, details: item.details!, date: item.date!, image: item.image ?? "sincelogo", showYears: item.displayyears, showDays: item.displaydays, showHours: item.displayhours, showMinutes: item.displayminutes)
                
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(widgetEvent)
            let url = AppGroup.since.containerURL.appendingPathComponent("widgetdata.json")
            try jsonData.write(to: url)
            print(jsonData)
        } catch {
            print("Save widget error: \(error)")
        }
        
    }
    
}

struct WidgetSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetSettingsView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
