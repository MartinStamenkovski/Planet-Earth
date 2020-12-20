//
//  ContentView.swift
//  Planet Earth
//
//  Created by Martin Stamenkovski on 20.11.20.
//

import SwiftUI
import EarthQuake
import Weather

struct ContentView: View {
    
    enum PETab: Hashable {
        case earthquake
        case weather
    }
    
    @State private var selection = PETab.weather
    
    var body: some View {
        TabView(selection: $selection) {
            WeatherView()
                .tabItem {
                    Image(systemName: "thermometer")
                    Text("Weather")
                }.tag(PETab.weather)
            
            EarthQuakeListView()
                .tabItem {
                    Image(systemName: "bolt.horizontal.fill")
                    Text("Earthquakes")
                }.tag(PETab.earthquake)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
