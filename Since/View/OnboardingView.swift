//
//  OnboardingView.swift
//  Since
//
//  Created by David Smailes on 29/10/2020.
//

import SwiftUI

struct OnboardingView: View {
    
    var onboardingItems: [OnboardingItem] = onboardingData
    
    var body: some View {
        TabView {
            ForEach(onboardingItems[0..<self.onboardingItems.count]) { item in
                OnboardingCardView(onboardingItem: item)
            } // loop
        } // tab
        .tabViewStyle(PageTabViewStyle())
        .padding(.vertical, 20)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
