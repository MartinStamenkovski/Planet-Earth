//
//  UVIndexService.swift
//  OpenWeatherAPI
//
//  Created by Martin Stamenkovski on 4.12.20.
//

import Foundation
import Combine
import CoreLocation

public enum LoadingState {
    case loading
    case success
    case error(Error)
}

public final class OpenWeatherService: ObservableObject {
    
    @Published private var locationManager = LocationManager()
    @Published public private(set) var state = LoadingState.loading
    
    public private(set) var weather: Weather?
    public private(set) var city: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    public init(endPoint: OpenWeatherEndPoints) {
        #if targetEnvironment(simulator)
        self.city = "Skopje"
        self.fetchData(
            from: URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=42&lon=21.43&exclude=alerts,minutely&appid=1401ad6496ff98b6401caab2e6cfa2d7")!,
            decodeTo: Weather.self) {[weak self] value in
            self?.weather = value
            self?.state = .success
        }
        #else
        self.locationManager.placemark.sink {[weak self] error in
            switch error {
            case .failure(let error):
                self?.state = .error(error)
                break
            default:
                break
            }
        } receiveValue: {[weak self] placemark in
            self?.city = placemark.name
            self?.fetchWeather(from: endPoint, coordinates: placemark.coordinate)
        }.store(in: &cancellables)
        #endif
    }
    
}

extension OpenWeatherService {
    
    func fetchWeather(from endPoint: OpenWeatherEndPoints, coordinates: CLLocationCoordinate2D) {
        var components = URLComponents(url: endPoint.url, resolvingAgainstBaseURL: true)
        components?.appendQueryItems(
            [
                "lat" : String(coordinates.latitude),
                "lon" : String(coordinates.longitude),
                "appid" : "1401ad6496ff98b6401caab2e6cfa2d7"
            ]
        )
        guard let url = components?.url else { return }
        self.fetchData(
            from: url,
            decodeTo: Weather.self) {[weak self] value in
            self?.weather = value
            self?.state = .success
        }
    }
    
    public func fetchWeather(for placemark: Placemark) {
        self.city = placemark.name
        self.fetchWeather(from: .weather, coordinates: placemark.coordinate)
    }
}

extension OpenWeatherService {
    
    private func fetchData<T>(from url: URL, decodeTo: T.Type, completion: @escaping((T) -> Void)) where T: Codable {
        self.state = .loading
        URLSession.shared.dataTaskPublisher(for: url)
            .compactMap {
                return $0.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink {[weak self] failure in
                switch failure {
                case .failure(let error):
                    self?.state = .error(error)
                    break
                default:
                    break
                }
            } receiveValue: { value in
                completion(value)
            }.store(in: &cancellables)
    }
}

extension URLComponents {
    
    mutating func appendQueryItems(_ items: [String: String?]) {
        self.queryItems = items.map { URLQueryItem(name: $0, value: $1)}
    }
}
