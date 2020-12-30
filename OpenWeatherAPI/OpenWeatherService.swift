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


public final class OpenWeatherService<T>: ObservableObject {
    
    private var locationManager = LocationManager()
    
    @Published public private(set) var state = ViewState<T>.loading
    
    public private(set) var currentLocation: Placemark?
    public private(set) var selectedPlacemark: Placemark?
    
    private var cancellables = Set<AnyCancellable>()
    
    public init(endPoint: OpenWeatherEndPoints) {
        #if targetEnvironment(simulator)
        
        self.currentLocation = Placemark(
            coordinate: CLLocationCoordinate2D(latitude: 42, longitude: 21.3),
            name: "Skopje",
            country: "North Macedonia",
            thoroughfare: "Debug Street"
        )
        self.fetchOpenWeatherData(from: endPoint, placemark: self.currentLocation!)
        #else
        self.locationManager.placemark.sink{ [weak self] result in
            switch result {
            case .failure(let error):
                guard self?.selectedPlacemark == nil else { return }
                self?.state = .error(error)
                break
            case .success(let placemark):
                self?.currentLocation = placemark
                guard self?.selectedPlacemark == nil else { return }
                self?.fetchOpenWeatherData(from: endPoint, placemark: placemark)
                break
            }
        }.store(in: &cancellables)
        #endif
    }
}

//MARK: Call open weather API request.
extension OpenWeatherService {
    
    func constructOpenWeatherURL(for endPoint: OpenWeatherEndPoints, placemark: Placemark) -> URL? {
       
        var components = URLComponents(url: endPoint.url, resolvingAgainstBaseURL: true)
        components?.appendQueryItems(
            [
                "lat" : String(placemark.coordinate.latitude),
                "lon" : String(placemark.coordinate.longitude),
                "appid" : InfoPlistValue.shared.openWeatherKey
            ]
        )
        return components?.url
    }
    
    func fetchOpenWeatherData(from endPoint: OpenWeatherEndPoints, placemark: Placemark, delay: Double = 0) {
        
        guard let url = self.constructOpenWeatherURL(for: endPoint, placemark: placemark) else { return }
        
        self.selectedPlacemark = placemark
        
        switch endPoint {
        case .weather:
            self.fetchData(from: url, decodeTo: Weather.self, delay: delay) {[weak self] weather in
                withAnimation(.easeInOut) {
                    self?.state = .success(weather as! T)
                }
            }
        case .airPollution, .airPollutionForecast:
            self.fetchAirPollution(for: placemark)
            break
        }
    }
    
}

//MARK: Current Weather
extension OpenWeatherService {
    
    public func fetchWeather(for placemark: Placemark, delay: Double = 0) {
        self.selectedPlacemark = placemark
        self.fetchOpenWeatherData(from: .weather, placemark: placemark, delay: delay)
    }
    
    public func retryWeatherRequest() {
        guard let placemark = self.selectedPlacemark else { return }
        self.fetchWeather(for: placemark, delay: 0)
    }
}

//MARK: Air Pollution
extension OpenWeatherService {
    
    public func fetchAirPollution(for placemark: Placemark) {

        guard let currentAirPollutionURL = self.constructOpenWeatherURL(for: .airPollution, placemark: placemark)
        else { return }
        guard let airPollutionForecastURL = self.constructOpenWeatherURL(for: .airPollutionForecast, placemark: placemark)
        else { return }

        self.selectedPlacemark = placemark

        self.state = .loading
        
        let currentAirPollutionRequest = URLSession.shared
            .dataTaskPublisherWithError(for: currentAirPollutionURL)
            .decode(type: Pollution.self, decoder: JSONDecoder())
        
        let airPollutionForecastRequest = URLSession.shared
            .dataTaskPublisherWithError(for: airPollutionForecastURL)
            .decode(type: Pollution.self, decoder: JSONDecoder())
        
        Publishers.Zip(currentAirPollutionRequest, airPollutionForecastRequest)
            .receive(on: RunLoop.main)
            .sink {[weak self] response in
                switch response {
                case .success((let pollution, let forecast)):
                    self?.state = .success((pollution, forecast) as! T)
                    break
                case .failure(let error):
                    self?.state = .error(.message(error.localizedDescription))
                    break
                }
            }.store(in: &cancellables)
    }
    
    public func retryAirPollutionRequest() {
        guard let placemark = self.selectedPlacemark else { return }
        self.fetchAirPollution(for: placemark)
    }
}

//MARK: Create & Execute open weather api request.
extension OpenWeatherService {
    
    private func fetchData<T>(from url: URL, decodeTo: T.Type, delay: Double = 0, completion: ((T) -> Void)? = nil)  where T: Codable {
        self.state = .loading
        URLSession.shared.dataTaskPublisherWithError(for: url)
            .decode(type: T.self, decoder: JSONDecoder())
            .delay(
                for: .seconds(delay),
                scheduler: RunLoop.main
            ).sink {[weak self] response in
                switch response {
                case .success(let data):
                    completion?(data)
                    break
                case .failure(let error):
                    self?.state = .error(.message(error.localizedDescription))
                    break
                }
            }.store(in: &cancellables)
    }
}
