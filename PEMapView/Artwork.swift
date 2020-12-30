//
//  Artwork.swift
//  EarthQuake
//
//  Created by Martin Stamenkovski on 23.11.20.
//

import MapKit

public class Artwork: NSObject, MKAnnotation, Identifiable {
    
    public var coordinate: CLLocationCoordinate2D
    
    public var glyphText: String?
    public var glyphImage: UIImage?
    
    public var title: String?
    public var subtitle: String?
    public var color: UIColor?
    
    public var id = UUID()
    
    public var userInfo: Any?
    public var span = MKCoordinateSpan(latitudeDelta: 0.0981713407839031, longitudeDelta: 0.061416481295538006)
    
    public init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String? = nil) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        super.init()
    }
}
