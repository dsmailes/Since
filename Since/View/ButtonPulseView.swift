//
//  ButtonPulseView.swift
//  Since
//
//  Created by David Smailes on 21/04/2021.
//

import SwiftUI



struct ButtonPulseView: View {
    
    @State private var showWaves = false
    
    var body: some View {
        ZStack {
            Circle() // wave
                .stroke(lineWidth: 6)
                .frame(width: 64, height: 64)
                .foregroundColor(Color.blue)
                .scaleEffect(showWaves ? 2 : 1)
                .hueRotation(.degrees(showWaves ? 360 : 0))
                .opacity(showWaves ? 0 : 1)
                .animation(Animation.easeOut(duration: 2).repeatForever(autoreverses: false).speed(1))
                .onAppear() {
                    self.showWaves.toggle()
                }
        } // zstack
    }
}

struct ButtonPulseView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonPulseView()
            .previewLayout(.sizeThatFits)
    }
}
