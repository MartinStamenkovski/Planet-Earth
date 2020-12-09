//
//  Placemark.swift
//  OpenWeatherAPI
//
//  Created by Martin Stamenkovski on 8.12.20.
//

import CoreLocation

public struct Placemark: Identifiable {
    
    public let id = UUID()
    
    public let name: String?
    public let coordinate: CLLocationCoordinate2D
    public let country: String?
}
