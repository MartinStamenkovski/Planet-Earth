//
//  LocationManager.swift
//  OpenWeatherAPI
//
//  Created by Martin Stamenkovski on 4.12.20.
//

import CoreLocation
import Combine
import MapKit

public class LocationManager: NSObject, ObservableObject {
    
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    private let searchRequest = MKLocalSearch.Request()
    private var localSearch: MKLocalSearch?
    
    public let placemark: PassthroughSubject<Result<Placemark, PEError>, Never> = PassthroughSubject()
    
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
            
            self.searchRequest.naturalLanguageQuery = query
            
            self.localSearch = MKLocalSearch(request: self.searchRequest)
            
            self.localSearch?.start { (response, error) in
                if let error = error {
                    self.placemark.send(.failure(.message(error.localizedDescription)))
                    return
                }
                guard let response = response else {
                    return
                }
               
                for item in response.mapItems {
                    if let name = item.name,
                       let location = item.placemark.location {
                        let placemark = Placemark(
                            coordinate: location.coordinate,
                            name: name,
                            country: item.placemark.country,
                            thoroughfare: item.placemark.thoroughfare
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
            let message = "Location permission is needed to show you weather data at your current location"
            self.placemark.send(.failure(.permissionDenied(message)))
            break
        @unknown default:
            break
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.geocoder.reverseGeocodeLocation(location) {[weak self] (placemarks, error) in
                if let placemark = placemarks?.first, let placemarkLocation = placemark.location {
                  
                    let currentPlacemark = Placemark(
                        coordinate: placemarkLocation.coordinate,
                        name: placemark.administrativeArea,
                        country: placemark.country,
                        thoroughfare: placemark.thoroughfare
                    )
                    self?.placemark.send(.success(currentPlacemark))
                    manager.stopUpdatingLocation()
                }
            }
        }
    }
}

