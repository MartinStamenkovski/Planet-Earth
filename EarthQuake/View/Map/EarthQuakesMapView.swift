//
//  EarthQuakesMapView.swift
//  EarthQuake
//
//  Created by Martin Stamenkovski on 23.11.20.
//

import SwiftUI
import PEMapView
import Extensions

struct EarthQuakesMapView: View {
    let quakes: [Quake]
    let selectedQuake: Quake?
    
    @State private var annotations: [Artwork] = []    
    @State private var selectedAnnotation: Artwork?
    
    init(_ quakes: [Quake], selected: Quake?) {
        self.quakes = quakes
        self.selectedQuake = selected
    }
    
    var body: some View {
        
        ZStack {
            PEMapView($annotations, selection: self.selectedQuake?.toAnnotation())
                .annotationSelectionChanged { artwork in
                    withAnimation(Animation.spring()) {
                        self.selectedAnnotation = artwork
                    }
                }
                .edgesIgnoringSafeArea([.leading, .trailing])
                .navigationBarTitle("Map", displayMode: .inline)
            
            VStack(alignment: .leading) {
                if let annotation = self.selectedAnnotation {
                    EarthQuakeDetails(quake: annotation.userInfo as! Quake)
                        .transition(.slideAndFade)
                    Spacer()
                }
            }
            .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
        }
        .onAppear {
            self.loadArtworks()
        }
    }
    
    func loadArtworks() {
        var artworks: [Artwork] = []
        
        for quake in self.quakes {
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
