//
//  SkipButtonView.swift
//  Since
//
//  Created by David Smailes on 22/04/2021.
//

import SwiftUI

struct SkipButtonView: View {
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    
    // MARK - BODY
    var body: some View {
        Button(action: {
            isOnboarding = false
        }) {
            HStack(spacing: 8) {
                Text("SKIP")
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

struct SkipButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SkipButtonView()
    }
}
