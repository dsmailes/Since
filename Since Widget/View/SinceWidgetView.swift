//
//  SinceWidgetView.swift
//  Since
//
//  Created by David Smailes on 26/10/2020.
//

import SwiftUI
import WidgetKit

struct SinceWidgetView: View {
    
    let event: WidgetSinceEvent
    
    @Environment(\.widgetFamily) var family
    
    @ViewBuilder
    var body: some View {
        
        switch family {
                case .systemSmall:
                    
                    ZStack {
                        Image(uiImage: ImageHandler.sharedInstance.getEventImage(imageName: event.image!))
                            .resizable()
                            .centerCropped()
                        
                        VStack(alignment: .leading) {
                            
                            Spacer()
                        
                            Text(event.title)
                            .fontWeight(.bold)
                            .font(.body)
                            .frame(maxWidth: .infinity)
                            .multilineTextAlignment(.center)
                            .background(Color(UIColor.systemBackground))
                            .lineLimit(1)
                            .font(.system(size: 500))
                            .minimumScaleFactor(0.01)
                            
                        Text(event.date, style: .relative)
                            .fontWeight(.semibold)
                            .font(.footnote)
                            .background(Color(UIColor.systemBackground))
                            .lineLimit(2)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 500))
                            .minimumScaleFactor(0.01)
                        
                        Spacer()
                            
                        } // vstack
                        .frame(maxWidth: .infinity)
                    } // zstack
                    
                case .systemMedium:
                    ZStack(alignment: .center) {
                        Image(uiImage: ImageHandler.sharedInstance.getEventImage(imageName: event.image!))
                            .resizable()
                            .centerCropped()
                            
                        VStack(alignment: .center) {
                            
                            Spacer()
                        
                            Text(event.title)
                            .fontWeight(.bold)
                            .font(.body)
                            .frame(maxWidth: .infinity)
                            .multilineTextAlignment(.center)
                            .background(Color(UIColor.systemBackground))
                            .lineLimit(1)
                            .font(.system(size: 500))
                            .minimumScaleFactor(0.01)
                            
                        Text(event.date, style: .relative)
                            .fontWeight(.semibold)
                            .font(.footnote)
                            .background(Color(UIColor.systemBackground))
                            .lineLimit(1)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 500))
                            .minimumScaleFactor(0.01)
                        
                        Spacer()
                            
                        } // vstack
                            .frame(maxWidth: .infinity)
                    } // zstack
                case .systemLarge:
                    ZStack() {
                        Image(uiImage: ImageHandler.sharedInstance.getEventImage(imageName: event.image!))
                            .resizable()
                            .centerCropped()
                        
                        VStack(alignment: .leading) {
                        
                            Text(event.title)
                            .fontWeight(.bold)
                            .font(.body)
                            .frame(maxWidth: .infinity)
                            .multilineTextAlignment(.center)
                            .background(Color(UIColor.systemBackground))
                            .lineLimit(1)
                            .font(.system(size: 500))
                            .minimumScaleFactor(0.01)
                            
                        Text(event.date, style: .relative)
                            .fontWeight(.semibold)
                            .font(.footnote)
                            .background(Color(UIColor.systemBackground))
                            .lineLimit(2)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 500))
                            .minimumScaleFactor(0.01)
                        
                        Spacer()
                            
                        } // vstack
                        .frame(maxWidth: .infinity)
                    }
                default:
                    Text("Some other WidgetFamily in the future.")
                }
        
        
       
    }
}

struct SinceWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        SinceWidgetView(event: WidgetSinceEvent(title: "Since Event", date: Date(), image: "sincelogo", showYears: true, showDays: true, showHours: true, showMinutes: true))
            .previewLayout(.sizeThatFits)
            .padding()
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        SinceWidgetView(event: WidgetSinceEvent(title: "Since Event", date: Date(), image: "sincelogo", showYears: true, showDays: true, showHours: true, showMinutes: true))
            .previewLayout(.sizeThatFits)
            .padding()
            .previewContext(WidgetPreviewContext(family: .systemMedium))
            
        SinceWidgetView(event: WidgetSinceEvent(title: "Since Event", date: Date(), image: "sincelogo", showYears: true, showDays: true, showHours: true, showMinutes: true))
            .previewLayout(.sizeThatFits)
            .padding()
            .previewContext(WidgetPreviewContext(family: .systemLarge))
        
    }
}
