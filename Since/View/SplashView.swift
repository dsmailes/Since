//
//  SplashView.swift
//  Since
//
//  Created by David Smailes on 29/10/2020.
//

import SwiftUI

struct SplashView: View {
    
    @State var animate: Bool = false
    @State var endSplash: Bool = false
    
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    
    var body: some View {
        VStack {
            
                ZStack {
                    if isOnboarding {
                        OnboardingView()
                    } else {
                        ContentView(storeManager: StoreManager(), addEventViewPresented: false, storeViewPresented: false)
                    }
                    
                    ZStack {
                        
                        Color("bg")
                        
                        Image("sincelarge")
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: animate ? .fill : .fit)
                            .frame(width: animate ? nil : 85, height: animate ? nil : 85)
                        
                        // scaling view
                            .scaleEffect(animate ? 3 : 1)
                        // setting width to avoid over size
                            .frame(width: UIScreen.main.bounds.width)
                        
                    }
                    .ignoresSafeArea(.all, edges: .all)
                    .onAppear(perform: animateSplash)
                    // hiding view after finished
                    .opacity(endSplash ? 0 : 1)
                    
                }
            
        }

    }
    
    func animateSplash() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            withAnimation(Animation.easeOut(duration: 0.55)) {
                animate.toggle()
            }
            
            withAnimation(Animation.linear(duration: 0.45)) {
                endSplash.toggle()
            }
        }
        
    }
    
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
