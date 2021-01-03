//
//  OnboardingCardView.swift
//  Since
//
//  Created by David Smailes on 29/10/2020.
//

import SwiftUI

struct OnboardingCardView: View {
    
    var onboardingItem: OnboardingItem
    
    @State private var isAnimating: Bool = false
    
    var body: some View {
        ZStack() {
            
            VStack(spacing: 20) {
                
                Image(systemName: onboardingItem.image)
                    .resizable()
                    .scaledToFit()
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 0, x: 6, y: 8)
                    .scaleEffect(isAnimating ? 1.0 : 0.6)
                    .padding()
                
                Text(onboardingItem.title)
                    .font(.title)
                    .fontWeight(.heavy)
                    .shadow(color: Color(red: 0, green:0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)
                
                Text(onboardingItem.information)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .frame(maxWidth: 480)
                
                if onboardingItem.final {
                    StartButtonView()
                }
                
            } // vstack
            
        } // zstack
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(LinearGradient(gradient: Gradient(colors: [ Color(UIColor.systemBackground), .accentColor]), startPoint: .top, endPoint: .bottom))
            .cornerRadius(20)
            .padding(.horizontal, 20)
    }
}

struct OnboardingCardView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingCardView(onboardingItem: onboardingData[4])
            
    }
}
