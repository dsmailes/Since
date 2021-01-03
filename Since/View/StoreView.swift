//
//  StoreView.swift
//  Since
//
//  Created by David Smailes on 03/01/2021.
//

import SwiftUI

struct StoreView: View {
    
    @StateObject var storeManager: StoreManager
    
    let productIDs = ["com.mylearningapps.Since.more_widgets"]
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List(storeManager.myProducts, id: \.self) { product in
                HStack {
                    VStack(alignment: .leading) {
                        Text(product.localizedTitle)
                            .font(.headline)
                        Text(product.localizedDescription)
                            .font(.caption2)
                    }
                    Spacer()
                    if UserDefaults.standard.bool(forKey: product.productIdentifier) {
                        Text ("Purchased")
                            .foregroundColor(.green)
                    } else {
                        Button(action: {
                            storeManager.purchaseProduct(product: product)
                            
                        }) {
                            Text(storeManager.returnPriceString(product: product))
                        }
                            .foregroundColor(.blue)
                    }
                } // hstack
            } // list
            .navigationTitle("Store")
            .onAppear() {
                storeManager.getProducts(productIDs: productIDs)
            }
        } // nav
    
    }
}

struct StoreView_Previews: PreviewProvider {
    static var previews: some View {
        StoreView(storeManager: StoreManager())
    }
}
