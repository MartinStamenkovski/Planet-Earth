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

public enum LoadingState {
    case loading
    case success
    case error(Error)
}

public final class OpenWeatherService: ObservableObject {
    
    @Published private var locationManager = LocationManager()

    @Published public private(set) var state = LoadingState.loading

    @Published public private(set) var savedCitiesWeather: [Weather] = []

    public private(set) var weather: Weather?
    
    public private(set) var currentLocation: Placemark?
    public private(set) var selectedPlacemark: Placemark?
    
    private var cancellables = Set<AnyCancellable>()
    
    public init(endPoint: OpenWeatherEndPoints) {
        #if targetEnvironment(simulator)
        
        self.currentLocation = Placemark(
            coordinate: CLLocationCoordinate2D(latitude: 42, longitude: 21.43),
            name: "Skopje",
            country: "North Macedonia"
        )
        self.selectedPlacemark = self.currentLocation
        self.fetchWeather(from: .weather, coordinates: CLLocationCoordinate2D(latitude: 42, longitude: 21.43))
        #else
        self.locationManager.placemark.sink{ [weak self] result in
            switch result {
            case .failure(let error):
                self?.state = .error(error)
                break
            case .success(let placemark):
                self?.currentLocation = placemark
                self?.selectedPlacemark = placemark
                self?.fetchWeather(from: endPoint, coordinates: placemark.coordinate)
                break
            }
        }.store(in: &cancellables)
        #endif
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
    
    public func fetchWeather(for placemarks: [Placemark], delay: Double = 0) {
        self.savedCitiesWeather.removeAll()
        
        var publishers = [AnyPublisher<Weather, Error>]()
        
        for placemark in placemarks {
            guard let url = self.constructOpenWeatherURL(for: .weather, coordinates: placemark.coordinate) else { continue }
            publishers.append(
                URLSession.shared.dataTaskPublisherWithError(for: url)
                    .decode(type: Weather.self, decoder: JSONDecoder())
                    .eraseToAnyPublisher()
            )
        }
        
        Publishers.MergeMany(publishers)
            .receive(on: RunLoop.main)
            .sink { _ in
                
            } receiveValue: { weather in
                self.savedCitiesWeather.append(weather)
            }.store(in: &cancellables)
    }
    
    public func weatherFor(latitude: Double, longitude: Double) -> Weather? {
        //print(savedCitiesWeather)
        let weather = self.savedCitiesWeather.first(where:  { $0.latitude == latitude && $0.longitude == longitude })
        print(weather)
        return weather
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
                    self?.state = .error(error)
                    break
                }
            }
            .store(in: &cancellables)
    }
}
