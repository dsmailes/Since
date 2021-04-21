//
//  BackgroundCard.swift
//  Room
//
//  Created by David Smailes on 16/04/2021.
//

import SwiftUI

struct BackgroundCard: ViewModifier {
    var radius: CGFloat = 8
    var border: CGFloat = 2
    var shadow: Double = 0.05
    
    func body(content: Content) -> some View {
        content
            .padding()                  // Padding around the edges of content
            .background(innerRect)      // White|Black background color
            .padding(border)            // Make space for border rectangle
            .background(outerRect)      // Dark|Light gray border rectangle
            .shadow(color: Color.black.opacity(shadow), radius: 4, x: 0, y: 4)
    }
    
    var innerRect: some View {
        RoundedRectangle(cornerRadius: radius, style: .continuous)
            .foregroundColor(Color("card"))
    }
    
    var outerRect: some View {
        RoundedRectangle(cornerRadius: (radius + border), style: .continuous)
            .foregroundColor(Color(UIColor.systemGray5))
    }
}

struct BackgroundCard_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hi there! I hope you find this simple ViewModifier useful.")
            .modifier(BackgroundCard())
    }
}
