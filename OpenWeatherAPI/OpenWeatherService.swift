//
//  UVIndexService.swift
//  OpenWeatherAPI
//
//  Created by Martin Stamenkovski on 4.12.20.
//

import Foundation
import Combine
import CoreLocation
import SwiftUI
import Extensions
import Helpers

public enum OpenWeatherState {
    case loading
    case success
    case error(PEError)
}

public final class OpenWeatherService: ObservableObject {
    
    private var locationManager = LocationManager()

    @Published public private(set) var state = OpenWeatherState.loading

    @Published public private(set) var savedCitiesWeather: [Weather] = []

    public private(set) var weather: Weather?
    
    public private(set) var currentLocation: Placemark?
    public private(set) var selectedPlacemark: Placemark?
    
    private var cancellables = Set<AnyCancellable>()
    
    public init(endPoint: OpenWeatherEndPoints) {
//        #if targetEnvironment(simulator)
//
//        self.currentLocation = Placemark(
//            coordinate: CLLocationCoordinate2D(latitude: 42, longitude: 21.43),
//            name: "Skopje",
//            country: "North Macedonia"
//        )
//        self.selectedPlacemark = self.currentLocation
//        self.fetchWeather(from: .weather, coordinates: CLLocationCoordinate2D(latitude: 42, longitude: 21.43))
//        #else
//
//        #endif
        
        self.locationManager.placemark.sink{ [weak self] result in
            switch result {
            case .failure(let error):
                switch error {
                case .permissionDenied:
                    let message = "Location permission is needed to show you weather at your current location"
                    self?.state = .error(.permissionDenied(message))
                    break
                default:
                    break
                }
                break
            case .success(let placemark):
                self?.currentLocation = placemark
                guard self?.selectedPlacemark == nil else { return }
                self?.selectedPlacemark = placemark
                self?.fetchWeather(from: endPoint, coordinates: placemark.coordinate)
                break
            }
        }.store(in: &cancellables)
    }
}

//MARK: Call open weather API request.
extension OpenWeatherService {
    
    func constructOpenWeatherURL(for endPoint: OpenWeatherEndPoints, coordinates: CLLocationCoordinate2D) -> URL? {
        var components = URLComponents(url: endPoint.url, resolvingAgainstBaseURL: true)
        components?.appendQueryItems(
            [
                "lat" : String(coordinates.latitude),
                "lon" : String(coordinates.longitude),
                "appid" : "1401ad6496ff98b6401caab2e6cfa2d7"
            ]
        )
        return components?.url
    }
    
    func fetchWeather(from endPoint: OpenWeatherEndPoints, coordinates: CLLocationCoordinate2D, delay: Double = 0) {
        
        guard let url = self.constructOpenWeatherURL(for: endPoint, coordinates: coordinates) else { return }
        self.fetchData(
            from: url,
            decodeTo: Weather.self,
            delay: delay) {[weak self] value in
            self?.weather = value
            withAnimation(.easeInOut) {
                self?.state = .success
            }
        }
    }
    
    public func fetchWeather(for placemark: Placemark, delay: Double = 0) {
        self.selectedPlacemark = placemark
        self.fetchWeather(from: .weather, coordinates: placemark.coordinate, delay: delay)
    }
    
    public func retryWeatherRequest() {
        guard let placemark = self.selectedPlacemark else { return }
        self.fetchWeather(for: placemark, delay: 0)
    }
}


//MARK: Create & Execute open weather api request.
extension OpenWeatherService {
    
    private func fetchData<T>(from url: URL, decodeTo: T.Type, delay: Double = 0, completion: @escaping((T) -> Void)) where T: Codable {
        self.state = .loading
        URLSession.shared.dataTaskPublisherWithError(for: url)
            .decode(type: T.self, decoder: JSONDecoder())
            .delay(
                for: .seconds(delay),
                scheduler: RunLoop.main
            ).sink {[weak self] result in
                switch result {
                case .success(let data):
                    completion(data)
                    break
                case .failure(let error):
                    self?.state = .error(.message(error.localizedDescription))
                    break
                }
            }
            .store(in: &cancellables)
    }
}
