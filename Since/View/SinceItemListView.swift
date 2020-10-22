//
//  SinceItemListView.swift
//  Since
//
//  Created by David Smailes on 22/10/2020.
//

import SwiftUI

struct SinceItemListView: View {
    
    let event: SinceEvent
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Image(event.image!)
                .resizable()
                .scaledToFill()
                .frame(width: 90, height: 90)
                .clipShape(RoundedRectangle(cornerRadius: 12.0))
    
            VStack(alignment: .leading, spacing: 8) {
                
                Text(String(Date().years(from: event.date!)) + " years since")
                    .font(.title3)
                    .fontWeight(.medium)
                    .lineLimit(2)
                
                Text(event.title!)
                    .font(.title2)
                    .fontWeight(.medium)
            
            } // VStack
        } // HStack
    }
}

struct SinceItemListView_Previews: PreviewProvider {
    static var previews: some View {
        SinceItemListView(event: <#SinceEvent#>)
    }
}
