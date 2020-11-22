//
//  EarthQuakeView.swift
//  EarthQuake
//
//  Created by Martin Stamenkovski on 21.11.20.
//

import SwiftUI
public struct EarthQuakeView: View {
    
    @ObservedObject private var service = EarthQuakeService()
    
    public init() { }
    
    public var body: some View {
        
        NavigationView {
            List {
                ForEach(service.quakesTimeline, id: \.id) { timeline in
                    Section(header: Text(timeline.time)) {
                        ForEach(timeline.quakes, id: \.id) { quake in
                            NavigationLink(destination: Text(quake.location?.name ?? "N/A")) {
                                QuakeRow(quake: quake)
                            }
                        }
                    }
                }
            }.navigationBarTitle(Text("Earthquakes"))
        }
    }
}

struct EarthQuakeView_Previews: PreviewProvider {
    static var previews: some View {
        EarthQuakeView()
    }
}
