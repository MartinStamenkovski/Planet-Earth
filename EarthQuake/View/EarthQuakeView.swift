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
            self.contentView().navigationBarTitle(Text("Earthquakes"))
        }
    }
    
    private func contentView() -> AnyView {
        switch  self.service.state {
        case .loading:
            return AnyView(ActivityIndicator(isAnimating: .constant(true)))
        case .error(let error):
            return AnyView(Text(error.localizedDescription))
        default:
            return AnyView(QuakesListView(quakesTimeline: service.quakesTimeline))
        }
    }

}

struct QuakesListView: View {
    let quakesTimeline: [QuakeTimeline]
    
    var body: some View {
        List {
            ForEach(quakesTimeline, id: \.id) { timeline in
                 Section(header: Text(timeline.time)) {
                     ForEach(timeline.quakes, id: \.id) { quake in
                        NavigationLink(destination: EarthQuakesMapView(quakes: quakes, coordinates: quake.location?.coordinates)) {
                             QuakeRow(quake: quake)
                         }
                     }
                 }
             }
        }
    }
    
    var quakes: [Quake] {
        return quakesTimeline.flatMap { $0.quakes }
    }
}

struct EarthQuakeView_Previews: PreviewProvider {
    static var previews: some View {
        EarthQuakeView()
    }
}
