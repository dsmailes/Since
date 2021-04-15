//
//  CenterCropped.swift
//  Since
//
//  Created by David Smailes on 27/10/2020.
//

import SwiftUI

extension Image {
    //crops an image to its centre so that it is aligned correctly on the widget / table
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, height: geo.size.height)
            .clipped()
        }
    }
}
