//
//  StoreManager.swift
//  Since
//
//  Created by David Smailes on 03/01/2021.
//

import Foundation
import StoreKit

class StoreManager: NSObject, ObservableObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    @Published var myProducts = [SKProduct]()
    @Published var transactionState: SKPaymentTransactionState?
    
    var request: SKProductsRequest!
    
    //receive and process list of products
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("did receive response")
        
        if !response.products.isEmpty {
            
            for fetchedProduct in response.products {
                
                DispatchQueue.main.async { [self] in
                    self.myProducts.append(fetchedProduct)
                }
                
            }
        } else {
            print("product array empty")
        }
        
        for invalidIdentifier in response.invalidProductIdentifiers {
            print("Invalid identifiers found: \(invalidIdentifier)")
        }
        
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Request did fail: \(error)")
    }
    
    //request list of products
    func getProducts(productIDs: [String]) {
        print("requesting products")
        
        let request = SKProductsRequest(productIdentifiers: Set(productIDs))
        request.delegate = self
        request.start()
        
    }
    
    //return the price as a localised string
    func returnPriceString(product: SKProduct) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.formatterBehavior = .behavior10_4
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = product.priceLocale
        let price1Str = numberFormatter.string(from: product.price)
        
        let price1String = String(describing: price1Str!)
        
        return price1String
        
    }
    
    //process the payment queue
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                transactionState = .purchasing
            case .purchased:
                UserDefaults.standard.setValue(true, forKey: transaction.payment.productIdentifier)
                queue.finishTransaction(transaction)
                transactionState = .purchased
            case .restored:
                UserDefaults.standard.setValue(true, forKey: transaction.payment.productIdentifier)
                queue.finishTransaction(transaction)
                transactionState = .restored
            case .failed, .deferred:
                print("Payment Queue Error: \(String(describing: transaction.error))")
                    queue.finishTransaction(transaction)
                    transactionState = .failed
            default:
            queue.finishTransaction(transaction)
            }
        }
    }
    
    //purchase product
    func purchaseProduct(product: SKProduct) {
        if SKPaymentQueue.canMakePayments() {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
        } else {
            print("User can't make payment")
        }
    }
    
    //restore purchase
    func restoreProducts() {
        print("Restoring products ...")
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
}
