//
//  AddButtonView.swift
//  Since
//
//  Created by David Smailes on 22/04/2021.
//

import SwiftUI

struct AddButtonView: View {
    var body: some View {
        Image(systemName: "plus.circle.fill")
            .resizable()
            .scaledToFit()
            .background(Circle()
                            .fill(Color(UIColor.systemBackground)))
            .frame(width: 64, height: 64, alignment: .center)
    }
}

struct AddButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddButtonView()
    }
}
