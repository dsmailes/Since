//
//  MainTabBarData.swift
//  Since
//
//  Created by David Smailes on 28/10/2020.
//

import SwiftUI
import Combine

final class MainTabBarData: ObservableObject {
    
    let customActionIndex: Int
    
    let objectWillChange = PassthroughSubject<MainTabBarData, Never>()
    
    var itemSelected: Int {
        
        didSet {
            if itemSelected == customActionIndex {
                itemSelected = oldValue
                isCustomItemSelected = true
            }
            objectWillChange.send(self)
        }
        
    }
    
    var isCustomItemSelected: Bool = false
    
    init(initialIndex: Int = 1, customItemIndex: Int) {
        self.customActionIndex = customItemIndex
        self.itemSelected = initialIndex
    }
    
}
