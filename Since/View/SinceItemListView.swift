//
//  SinceItemListView.swift
//  Since
//
//  Created by David Smailes on 22/10/2020.
//

import SwiftUI
import CoreData

struct SinceItemListView: View {
    
    @ObservedObject var event: SinceEvent
    
    @AppStorage("demonstratedLongPress") var demonstratedLongPress: Bool = false
    
    var timeString: String = ""
    
    var body: some View {
        ZStack {
            HStack(alignment: .center, spacing: 16) {
                if event.image != nil {
                    
                    if let img = ImageHandler.sharedInstance.retrieveImage(forKey: event.image!, inStorageType: .fileSystem) {
                        Image(uiImage: img)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 90, height: 90)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                            
                    } else {
                        Image("sincelogo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 90, height: 90)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                    }
                    
                } else {
                    Image("sincelogo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 90, height: 90)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Spacer()
                        
                        Text(verbatim: event.title ?? "")
                            .font(.largeTitle)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                        
                    } // hstack
                
                    HStack {
                        Spacer()
                        VStack {
                            Text(event.date ?? Date(), style: .relative)
                            
                        } // vstack
                        Spacer()
                    } // hstack
                    
                } // VStack
                
            } // HStack
            .modifier(BackgroundCard())
            
            if !demonstratedLongPress {
                ListItemPulseView()
            }
            
        } // zstack

    }
    
}

struct SinceItemListView_Previews: PreviewProvider {
    
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
        
        return SinceItemListView(event: dEvent)
            .previewLayout(.sizeThatFits)
            .padding()
        
    }
    
}
