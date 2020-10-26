//
//  SinceItemListView.swift
//  Since
//
//  Created by David Smailes on 22/10/2020.
//

import SwiftUI
import CoreData

struct SinceItemListView: View {
    
    let event: SinceEvent
    
    var timeString: String = ""
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            if event.image != nil {
                
                if let img = ImageHandler.sharedInstance.retrieveImage(forKey: event.image!, inStorageType: .fileSystem) {
                    Image(uiImage: img)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 12.0))
                        .padding()
                } else {
                    Image("sincelogo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 12.0))
                        .padding()
                }
                
            } else {
                Image("sincelogo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 12.0))
                    .padding()
            }
            
            //Spacer()
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Spacer()
                    
                    Text(verbatim: event.title!)
                        .font(.largeTitle)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                } // hstack
            
                HStack {
                    Spacer()
                    VStack {
                        if event.displayyears {
                            Text(String(Date().years(from: event.date!)) + " years")
                                .font(.footnote)
                                .fontWeight(.medium)
                                .lineLimit(1)
                                .multilineTextAlignment(.leading)
                        }
                        
                        if event.displaydays {
                            Text(String(Date().days(from: event.date!)) + " days")
                                .font(.footnote)
                                .fontWeight(.medium)
                                .lineLimit(1)
                                .multilineTextAlignment(.leading)
                        }
                        if event.displayhours {
                            Text(String(Date().hours(from: event.date!)) + " hours")
                                .font(.footnote)
                                .fontWeight(.medium)
                                .lineLimit(1)
                                .multilineTextAlignment(.trailing)
                        }
                        
                        if event.displayminutes {
                            Text(String(Date().minutes(from: event.date!)) + " minutes")
                                .font(.footnote)
                                .fontWeight(.medium)
                                .lineLimit(1)
                                .multilineTextAlignment(.trailing)
                        }
                    } // vstack
                    Spacer()
                } // hstack
                
               
            } // VStack
            
        } // HStack
    }
}

struct SinceItemListView_Previews: PreviewProvider {
    
    static let moc = PersistenceController().container.viewContext

    static var previews: some View {
        
        let dEvent = SinceEvent(context: moc)
        
        dEvent.title = "Wedding"
        dEvent.date = Date()
        dEvent.image = "married"
        dEvent.details = "Got married."
        dEvent.displaydays = true
        dEvent.displayyears = true
        dEvent.displayhours = true
        dEvent.displayminutes = true
        
        return SinceItemListView(event: dEvent)
            .previewLayout(.sizeThatFits)
            .padding()
        
    }
    
}
