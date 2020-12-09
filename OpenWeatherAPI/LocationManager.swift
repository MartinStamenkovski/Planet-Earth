//
//  LocationManager.swift
//  OpenWeatherAPI
//
//  Created by Martin Stamenkovski on 4.12.20.
//

import CoreLocation
import Combine
import MapKit

public enum LocationPermissionError: Error {
    case denied
}

public class LocationManager: NSObject, ObservableObject {
    
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    private let searchRequest = MKLocalSearch.Request()
    private var localSearch: MKLocalSearch?
    
    var placemark: PassthroughSubject<Placemark, Error> = PassthroughSubject()
    
    private var currentPlacemark: Placemark? {
        willSet {
            if let value = newValue {
                self.placemark.send(value)
            }
        }
    }
    
    lazy var mkLocalSearchQueue: OperationQueue = {
        let operation = OperationQueue()
        operation.maxConcurrentOperationCount = 1
        return operation
    }()
    
    override public init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    public func searchPlace(with query: String, completion: @escaping (([Placemark]) -> Void)) {
        self.mkLocalSearchQueue.addOperation {
            var searchedCities = [Placemark]()
            
            self.localSearch?.cancel()
            
            self.searchRequest.resultTypes = .address
            self.searchRequest.naturalLanguageQuery = query
            
            self.localSearch = MKLocalSearch(request: self.searchRequest)
            
            self.localSearch?.start { (response, error) in
                guard let response = response else {
                    return
                }
                for item in response.mapItems {
                    if let name = item.name,
                       let location = item.placemark.location {
                        let placemark = Placemark(
                            name: name,
                            coordinate: location.coordinate,
                            country: item.placemark.country
                        )
                        searchedCities.append(placemark)
                    }
                }
                completion(searchedCities)
            }
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
            break
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            break
        case .restricted, .denied:
            self.placemark.send(completion: .failure(LocationPermissionError.denied))
            break
        @unknown default:
            break
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.geocoder.reverseGeocodeLocation(location) {[weak self] (placemarks, error) in
                if let placemark = placemarks?.first, let placemarkLocation = placemark.location {
                    self?.currentPlacemark = Placemark(
                        name: placemark.administrativeArea,
                        coordinate: placemarkLocation.coordinate,
                        country: placemark.country
                    )
                    manager.stopUpdatingLocation()
                }
            }
        }
    }
}

