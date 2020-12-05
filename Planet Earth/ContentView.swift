//
//  ContentView.swift
//  Planet Earth
//
//  Created by Martin Stamenkovski on 20.11.20.
//

import SwiftUI
import EarthQuake
import UVIndex
import Weather

struct ContentView: View {
    
    enum PETab: Hashable {
        case earthquake
        case uvIndex
        case weather
    }
    
    @State private var selection = PETab.earthquake
    
    var body: some View {
        TabView(selection: $selection) {
            EarthQuakeListView()
                .tabItem {
                    Image(systemName: "bolt.horizontal.fill")
                    Text("Earthquakes")
                }.tag(PETab.earthquake)
            WeatherView()
                .tabItem {
                    Image(systemName: "thermometer")
                    Text("Weather")
                }.tag(PETab.weather)
            UVIndexView()
                .tabItem {
                    Image(systemName: "sun.max.fill")
                    Text("UV Index")
                }.tag(PETab.uvIndex)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
