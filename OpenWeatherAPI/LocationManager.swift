//
//  LocationManager.swift
//  OpenWeatherAPI
//
//  Created by Martin Stamenkovski on 4.12.20.
//

import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject {
    
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    var coordinates: PassthroughSubject<CLLocationCoordinate2D, Never> = PassthroughSubject()
    
    private var locationCoordinates: CLLocationCoordinate2D? {
        willSet {
            if let value = newValue {
                self.coordinates.send(value)
            }
        }
    }
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
            break
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            break
        case .restricted, .denied:
            break
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.geocoder.reverseGeocodeLocation(location) {[weak self] (placemarks, error) in
                if let _ = placemarks?.first {
                    self?.locationCoordinates = location.coordinate
                    manager.stopUpdatingLocation()
                }
            }
        }
    }
}
