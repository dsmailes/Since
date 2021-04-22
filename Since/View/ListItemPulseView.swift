//
//  ListItemPulseView.swift
//  Since
//
//  Created by David Smailes on 22/04/2021.
//

import SwiftUI

struct ListItemPulseView: View {
    
    @State private var showWaves = false
    
    var body: some View {
        Rectangle() // wave
            .stroke(lineWidth: 6)
            .cornerRadius(8)
            .foregroundColor(Color("AccentColor"))
            .scaleEffect(showWaves ? 0.7 : 1)
            .opacity(showWaves ? 0 : 1)
            .animation(Animation.easeInOut(duration: 4).repeatForever(autoreverses: false).speed(1))
            .onAppear() {
                self.showWaves.toggle()
            }
    }
}

struct ListItemPulseView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemPulseView()
    }
}
