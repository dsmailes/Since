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
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \SinceEvent.date, ascending: true)], animation: .default)
    
    private var events: FetchedResults<SinceEvent>
    
    @State var addEventViewPresented: Bool
    
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
                        Group {
                            Button("Set as widget 1", action: {
                                self.saveWidgetData(widgetNumber : 0, item: item)
                            })
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
                        }
                        
                    }
 
                }
                .onDelete(perform: deleteItems)
                
            } // List
            .listStyle(InsetListStyle())
            .navigationBarTitle("Since...", displayMode: .large)
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
                Button(action: {
                    self.addEventViewPresented.toggle()
                }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .background(Circle()
                                        .fill(Color(UIColor.systemBackground)))
                        .frame(width: 64, height: 64, alignment: .center)
                }
            } // zstack
            .padding(.bottom, 15)
            .padding(.trailing, 15)
            , alignment: .bottomTrailing
            
            
        )

    }
    
    private func saveWidgetData(widgetNumber: Int, item: SinceEvent) {
        
        let widgetEvent = WidgetSinceEvent(title: item.title!, date: item.date!, image: item.image ?? "sincelogo", showYears: item.displayyears, showDays: item.displaydays, showHours: item.displayhours, showMinutes: item.displayminutes)
                
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(widgetEvent)
            let widgetName = "widgetdata" + String(widgetNumber)
            let url = AppGroup.since.containerURL.appendingPathComponent(widgetName + ".json")
            
            try jsonData.write(to: url)
            WidgetCenter.shared.reloadAllTimelines()
            print(jsonData)
            self.acknowledgementShowing = true
            self.acknowledgementTitle = "Widget changed"
            self.acknowledgementMessage = "You have set \(widgetEvent.title) as widget " + String(widgetNumber + 1)
            return
        } catch {
            print("Save widget error: \(error)")
        }
        
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { events[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
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
        
        return ContentView(addEventViewPresented: false).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
