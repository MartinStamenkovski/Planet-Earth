//
//  Placemark.swift
//  OpenWeatherAPI
//
//  Created by Martin Stamenkovski on 8.12.20.
//

import CoreLocation
import PEDatabase

public struct Placemark: Identifiable {
    
    public let id = UUID()
    
    public let name: String?
    public let coordinate: CLLocationCoordinate2D
    public let country: String?
    
    public init(coordinate: CLLocationCoordinate2D, name: String?, country: String?) {
        self.coordinate = coordinate
        self.name = name
        self.country = country
    }
    
    public init(from city: City) {
        self.coordinate = CLLocationCoordinate2D(
            latitude: city.latitude,
            longitude: city.longitude
        )
        self.name = city.name
        self.country = city.country
    }
}
