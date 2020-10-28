//
//  Size.swift
//  Since
//
//  Created by David Smailes on 28/10/2020.
//

import SwiftUI

struct Size: PreferenceKey {
    
    typealias Value = [CGRect]
    static var defaultValue: [CGRect] = []
    static func reduce(value: inout [CGRect], nextValue: () -> [CGRect]) {
        value.append(contentsOf: nextValue())
    }
    
}
