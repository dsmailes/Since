//
//  ContentView.swift
//  Since
//
//  Created by David Smailes on 22/10/2020.
//

import SwiftUI
import CoreData
import WidgetKit

struct ContentView: View {
    
    @AppStorage("demonstratedLongPress") var demonstratedLongPress: Bool?
    
    @StateObject var storeManager: StoreManager
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \SinceEvent.date, ascending: true)], animation: .default)
    
    private var events: FetchedResults<SinceEvent>
    
    @State var addEventViewPresented: Bool
    
    @State var storeViewPresented: Bool
    
    @State var showAddButton: Bool = true
    
    @State private var acknowledgementShowing: Bool = false
    @State private var acknowledgementTitle: String = ""
    @State private var acknowledgementMessage: String = ""
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(self.events, id: \.self) { item in
                    NavigationLink(destination: EditItemView(event: item).environment(\.managedObjectContext, self.viewContext)) {
                        
                        SinceItemListView(event: item)
                    }
                    .isDetailLink(true)
                    .contextMenu {
                            Button("Set as widget 1", action: {
                                self.saveWidgetData(widgetNumber : 0, item: item)
                            })
                            if UserDefaults.standard.bool(forKey: "com.mylearningapps.Since.more_widgets") {
                                Button("Set as widget 2", action: {
                                    self.saveWidgetData(widgetNumber : 1, item: item)
                                })
                                Button("Set as widget 3", action: {
                                    self.saveWidgetData(widgetNumber : 2, item: item)
                                })
                                Button("Set as widget 4", action: {
                                    self.saveWidgetData(widgetNumber : 3, item: item)
                                })
                                Button("Set as widget 5", action: {
                                    self.saveWidgetData(widgetNumber : 4, item: item)
                                })
                            } else {
                                Button("Unlock more", action: {
                                    self.storeViewPresented.toggle()
                                })
                                Button("Restore Purchases", action: {
                                    storeManager.restoreProducts()
                                })
                            }
                    } // context menu
                    
 
                }
                .onDelete(perform: deleteItems)
                
                
            } // List
            .listStyle(InsetListStyle())
            .navigationBarTitle("Since...", displayMode: .inline)
            .background(Color.clear)
            .sheet(isPresented: $addEventViewPresented) {
                AddEventView().environment(\.managedObjectContext, self.viewContext)
            }
            
            
        } // nav
        .alert(isPresented: $acknowledgementShowing) {
                    Alert(title: Text(acknowledgementTitle), message:
        Text(acknowledgementMessage), dismissButton: .default(Text("OK")))
            }
        .overlay(
            ZStack {
                //show the add button if not in the add/editing view
                if self.showAddButton {
                    Button(action: {
                        self.addEventViewPresented.toggle()
                    }) {
                        AddButtonView()
                    }
                }
                //show pulse if no events are added to prompt user
                if events.count == 0 {
                    ButtonPulseView()
                }
            } // zstack
            .padding(.bottom, 15)
            .padding(.trailing, 15)
            , alignment: .bottomTrailing
            
            
        )
        .sheet(isPresented: $storeViewPresented) {
            StoreView(storeManager: StoreManager())
        }

    }
    
    //encode and transfer data to widget
    private func saveWidgetData(widgetNumber: Int, item: SinceEvent) {
        
        demonstratedLongPress = true
        
        let widgetEvent = WidgetSinceEvent(title: item.title!, date: item.date!, image: item.image ?? "sincelogo", showYears: item.displayyears, showDays: item.displaydays, showHours: item.displayhours, showMinutes: item.displayminutes)
                
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(widgetEvent)
            let widgetName = "widgetdata" + String(widgetNumber)
            let url = AppGroup.since.containerURL.appendingPathComponent(widgetName + ".json")
            
            try jsonData.write(to: url)
            WidgetCenter.shared.reloadAllTimelines()
            self.acknowledgementShowing = true
            self.acknowledgementTitle = "Widget changed"
            self.acknowledgementMessage = "You have set \(widgetEvent.title) as widget " + String(widgetNumber + 1)
            return
        } catch {
            
            self.acknowledgementShowing = true
            self.acknowledgementTitle = "Widget error"
            self.acknowledgementMessage = "Save widget error: \(error)"
            return
        }
        
    }

    //delete event from list
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { events[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                self.acknowledgementShowing = true
                self.acknowledgementTitle = "Delete error"
                self.acknowledgementMessage = "Delete widget error: \(error)"
                return
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static let moc = PersistenceController().container.viewContext
    
    static var previews: some View {
        
        let dEvent = SinceEvent(context: moc)
        
        dEvent.title = "Wedding"
        dEvent.date = Date()
        dEvent.image = "married"
        dEvent.displaydays = true
        dEvent.displayyears = true
        dEvent.displayhours = true
        dEvent.displayminutes = true
        
        return ContentView(storeManager: StoreManager(), addEventViewPresented: false, storeViewPresented: false).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .preferredColorScheme(.light)
    }
}
