//
//  StartButtonView.swift
//  Fructus
//
//  Created by David Smailes on 08/10/2020.
//

import SwiftUI

struct StartButtonView: View {
    // MARK - PROPERTIES
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    
    // MARK - BODY
    var body: some View {
        Button(action: {
            isOnboarding = false
        }) {
            HStack(spacing: 8) {
                Text("GO")
                    .font(.title)
                    .fontWeight(.heavy)
                
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                Capsule().strokeBorder(Color(UIColor.tertiarySystemFill), lineWidth: 1.25)
            )
        } //: BUTTON
        .accentColor(Color.black)
    }
}

// MARK - PREVIEW

struct StartButtonView_Previews: PreviewProvider {
    static var previews: some View {
        StartButtonView()
            .preferredColorScheme(.light)
            .previewLayout(.sizeThatFits)
    }
}
