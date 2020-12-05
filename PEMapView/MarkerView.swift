//
//  MarkerView.swift
//  EarthQuake
//
//  Created by Martin Stamenkovski on 23.11.20.
//

import MapKit

public class MarkerView: MKMarkerAnnotationView {
    public override var annotation: MKAnnotation? {
        willSet {
            guard let artwork = newValue as? Artwork else { return }
            
            animatesWhenAdded = true
            canShowCallout = true
            calloutOffset = CGPoint(x: 0, y: 5)
            glyphImage = artwork.glyphImage
            glyphText = artwork.glyphText
            markerTintColor = artwork.color
         
            clusteringIdentifier = nil
            collisionMode = .circle
        }
    }
}
