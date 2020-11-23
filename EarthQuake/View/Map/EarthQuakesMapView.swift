//
//  EarthQuakesMapView.swift
//  EarthQuake
//
//  Created by Martin Stamenkovski on 23.11.20.
//

import SwiftUI
import MapKit

struct EarthQuakesMapView: View {
    let quakes: [Quake]
    let coordinates: CLLocationCoordinate2D?
    
    var body: some View {
        MapView()
            .addAnnotations(artworks)
            .setRegion(coordinates, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
            .edgesIgnoringSafeArea([.leading, .trailing])
            .navigationBarTitle("Map", displayMode: .inline)
    }
    
    var artworks: [Artwork] {
        var artworks: [Artwork] = []
        for quake in quakes {
            guard let location = quake.location, let coordinates = location.coordinates else { continue }
            let artwork = Artwork(coordinate: coordinates, title: location.country, subtitle: location.name)
            artwork.glyphText = quake.magnitude
            artwork.color = quake.magnitudeColor
            artworks.append(artwork)
        }
        return artworks
    }
}

struct EarthQuakesMapView_Previews: PreviewProvider {
    static var previews: some View {
        EarthQuakesMapView(quakes: [], coordinates: nil)
    }
}
