//
//  SinceWidgetView.swift
//  Since
//
//  Created by David Smailes on 26/10/2020.
//

import SwiftUI
import WidgetKit

struct SinceWidgetView: View {
    
    let image: String
    let text: String
    
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        
        
        
        switch family {
                case .systemSmall:
                    ZStack() {
                        if image != "" {
                            
                            if let img = ImageHandler.sharedInstance.retrieveImage(forKey: image, inStorageType: .fileSystem) {
                                Image(uiImage: img)
                                    .resizable()
                                    .scaledToFill()
                                    
                            } else {
                                Image("sincelogo")
                                    .resizable()
                                    .scaledToFill()
                                    
                            }
                            
                        } else {
                            Image("sincelogo")
                                .resizable()
                                .scaledToFill()
                                
                        }
                        Text(text)
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                    }
                case .systemMedium:
                    HStack {
                        if image != "" {
                            
                            if let img = ImageHandler.sharedInstance.retrieveImage(forKey: image, inStorageType: .fileSystem) {
                                Image(uiImage: img)
                                    .resizable()
                                    .scaledToFill()
                                    
                            } else {
                                Image("sincelogo")
                                    .resizable()
                                    .scaledToFill()
                                    
                            }
                            
                        } else {
                            Image("sincelogo")
                                .resizable()
                                .scaledToFill()
                                
                        }
                        Spacer()
                        Text(text)
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                    }
                case .systemLarge:
                    ZStack() {
                        if image != "" {
                            
                            if let img = ImageHandler.sharedInstance.retrieveImage(forKey: image, inStorageType: .fileSystem) {
                                Image(uiImage: img)
                                    .resizable()
                                    .scaledToFill()
                                    
                            } else {
                                Image("sincelogo")
                                    .resizable()
                                    .scaledToFill()
                                    
                            }
                            
                        } else {
                            Image("sincelogo")
                                .resizable()
                                .scaledToFill()
                                
                        }
                        Text(text)
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                    }
                default:
                    Text("Some other WidgetFamily in the future.")
                }
        
        
       
    }
}

struct SinceWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        SinceWidgetView(image: "sincelogo", text: "10")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
