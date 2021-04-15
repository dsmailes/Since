//
//  OnboardingData.swift
//  Since
//
//  Created by David Smailes on 29/10/2020.
//

import Foundation


// data for the onboarding screen
let onboardingData: [OnboardingItem] = [

    OnboardingItem(id: UUID.init(), title: "Adding events", information: "To add events, tap the + button", image: "plus.circle", final: false),
    OnboardingItem(id: UUID.init(), title: "Setting the widget", information: "To set the widget, long press an event", image:"hand.tap.fill", final: false),
    OnboardingItem(id: UUID.init(), title: "Deleting", information: "To delete an event, swipe left and tap Delete", image:"hand.draw.fill", final: false),
    OnboardingItem(id: UUID.init(), title: "Editing", information: "To edit an event, tap on it", image: "hand.tap.fill", final: false),
    OnboardingItem(id: UUID.init(), title: "Welcome!", information: "To get started, tap the Start button below", image: "face.smiling.fill", final: true)
    
]
