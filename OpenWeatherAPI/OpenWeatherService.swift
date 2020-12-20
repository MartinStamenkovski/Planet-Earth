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

public final class OpenWeatherService: ObservableObject {
    
    private var locationManager = LocationManager()

    @Published public private(set) var state = ViewState.loading

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
                self?.selectedPlacemark = placemark
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
                "appid" : "1401ad6496ff98b6401caab2e6cfa2d7"
            ]
        )
        return components?.url
    }
    
    func fetchOpenWeatherData(from endPoint: OpenWeatherEndPoints, placemark: Placemark, delay: Double = 0) {
        
        guard let url = self.constructOpenWeatherURL(for: endPoint, placemark: placemark) else { return }
        switch endPoint {
        case .weather:
            self.fetchData(from: url, decodeTo: Weather.self, delay: delay) {[weak self] value in
                self?.weather = value
                withAnimation(.easeInOut) {
                    self?.state = .success
                }
            }.store(in: &cancellables)
        default:
            let weather = self.fetchData(from: url, decodeTo: Weather.self)
            let daily = self.fetchData(from: url, decodeTo: DailyWeather.self)
            
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

//MARK: Create & Execute open weather api request.
extension OpenWeatherService {
    
    private func fetchData<T>(from url: URL, decodeTo: T.Type, delay: Double = 0, completion: ((T) -> Void)? = nil) -> AnyCancellable where T: Codable {
        self.state = .loading
         return URLSession.shared.dataTaskPublisherWithError(for: url)
            .decode(type: T.self, decoder: JSONDecoder())
            .delay(
                for: .seconds(delay),
                scheduler: RunLoop.main
            ).sink {[weak self] result in
                switch result {
                case .success(let data):
                    completion?(data)
                    break
                case .failure(let error):
                    self?.state = .error(.message(error.localizedDescription))
                    break
                }
            }
    }
}
