//
//  ContentView.swift
//  Since
//
//  Created by David Smailes on 22/10/2020.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
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
                    ForEach(events) { item in
                        SinceItemListView(event: item)
                    }
                    .onDelete(perform: deleteItems)
                } // List
                .toolbar {
                    Button(action: {
                        self.showingAddEventView.toggle()
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
                .navigationBarTitle("Since...", displayMode: .large)
            } // zstack
            .sheet(isPresented: $showingAddEventView) {
                AddEventView().environment(\.managedObjectContext, self.viewContext)
            }
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

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
