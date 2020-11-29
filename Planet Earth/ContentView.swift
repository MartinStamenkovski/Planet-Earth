//
//  ContentView.swift
//  Planet Earth
//
//  Created by Martin Stamenkovski on 20.11.20.
//

import SwiftUI
import EarthQuake

struct ContentView: View {
    
    enum PETab: Hashable {
        case earthquake
    }
    
    var body: some View {
        TabView {
            EarthQuakeListView()
                .tabItem {
                    Image(systemName: "bolt.horizontal.fill")
                    Text("Earthquakes")
                }.tag(PETab.earthquake)
            Color.red.tabItem {
                Text("Colors")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
