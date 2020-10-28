//
//  ContentView.swift
//  Since
//
//  Created by David Smailes on 22/10/2020.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \SinceEvent.date, ascending: true)], animation: .default)
    
    private var events: FetchedResults<SinceEvent>
    
    @State var addEventViewPresented: Bool
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(self.events, id: \.self) { item in
                    SinceItemListView(event: item)
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
                        .frame(width: 72, height: 72, alignment: .center)
                }
            } // zstack
            .padding(.bottom, 30)
            .padding(.trailing, 30)
            , alignment: .bottomTrailing
            
            
        )

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
