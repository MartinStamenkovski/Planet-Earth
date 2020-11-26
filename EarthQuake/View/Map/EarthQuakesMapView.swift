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
    let selectedQuake: Quake?
    
    @State private var annotations: [Artwork] = []
    @State private var region: MKCoordinateRegion?
        
    @State private var selectedAnnotation: Artwork?
    
    init(_ quakes: [Quake], selected: Quake?) {
        self.quakes = quakes
        self.selectedQuake = selected
    }
    
    var body: some View {
        
        ZStack {
            PEMapView($annotations, selection: self.selectedQuake?.toAnnotation())
                .annotationSelectionChanged { artwork in
                    self.selectedAnnotation = artwork
                }
                .edgesIgnoringSafeArea([.leading, .trailing])
                .navigationBarTitle("Map", displayMode: .inline)
                .onAppear {
                    self.loadArtworks()
                }
            if let ann = self.selectedAnnotation {
                VStack {
                    Text(ann.title!)
                        .background(Color.white)
                        .padding()
                    Spacer()
                }
            }
        }
    }
    
    func loadArtworks() {
        var artworks: [Artwork] = []
       
        for quake in self.quakes {
            //guard quake.id != self.selectedQuake?.id else { continue }
            guard let artwork = quake.toAnnotation() else { continue }
            artworks.append(artwork)
        }
        self.annotations = artworks
        
    }
   
}

struct EarthQuakesMapView_Previews: PreviewProvider {
    static var previews: some View {
        EarthQuakesMapView([], selected: nil)
    }
}
