//
//  Artwork.swift
//  EarthQuake
//
//  Created by Martin Stamenkovski on 23.11.20.
//

import MapKit

class Artwork: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    
    var glyphText: String?
    var glyphImage: UIImage?
    
    var title: String?
    var subtitle: String?
    var color: UIColor?
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String? = nil) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        super.init()
    }
}
