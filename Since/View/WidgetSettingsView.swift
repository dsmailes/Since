//
//  WidgetSettingsView.swift
//  Since
//
//  Created by David Smailes on 22/10/2020.
//

import SwiftUI
import CoreData
import WidgetKit

struct WidgetSettingsView: View {
    
    @State private var showingAddEventView: Bool = false
    
    @State private var acknowledgementShowing: Bool = false
    @State private var acknowledgementTitle: String = ""
    @State private var acknowledgementMessage: String = ""
    
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
        .alert(isPresented: $acknowledgementShowing) {
                    Alert(title: Text(acknowledgementTitle), message:
        Text(acknowledgementMessage), dismissButton: .default(Text("OK")))
            }
    }
    
    func saveWidgetData(item: SinceEvent) {
        
        let widgetEvent = WidgetSinceEvent(title: item.title!, date: item.date!, image: item.image ?? "sincelogo", showYears: item.displayyears, showDays: item.displaydays, showHours: item.displayhours, showMinutes: item.displayminutes)
                
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(widgetEvent)
            let url = AppGroup.since.containerURL.appendingPathComponent("widgetdata.json")
            
            try jsonData.write(to: url)
            WidgetCenter.shared.reloadAllTimelines()
            print(jsonData)
            self.acknowledgementShowing = true
            self.acknowledgementTitle = "Widget changed"
            self.acknowledgementMessage = "You have set \(widgetEvent.title) as the current widget. Be aware this may take time to change over."
            return
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
