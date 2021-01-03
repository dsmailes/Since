//
//  OnboardingItem.swift
//  Since
//
//  Created by David Smailes on 29/10/2020.
//

import Foundation

struct OnboardingItem: Codable, Identifiable {
    
    var id: UUID
    var title: String
    var information: String
    var image: String
    var final: Bool
    
}
