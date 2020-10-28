//
//  ArrowView.swift
//  Since
//
//  Created by David Smailes on 28/10/2020.
//

import SwiftUI

struct ArrowView: View {
    var body: some View {
        GeometryReader { proxy in
                Image("emptyarrow").preference(key: Size.self, value: [proxy.frame(in: CoordinateSpace.global)])
            
        }
    }
}

struct ArrowView_Previews: PreviewProvider {
    static var previews: some View {
        ArrowView()
    }
}
