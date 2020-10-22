//
//  MainView.swift
//  Since
//
//  Created by David Smailes on 22/10/2020.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Text("List")
                    Image(systemName: "list.bullet")
                }
            WidgetSettingsView()
                .tabItem {
                    Text("Widget")
                }
            SettingsView()
                .tabItem {
                    Text("Settings")
                }
        } // tabview
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
