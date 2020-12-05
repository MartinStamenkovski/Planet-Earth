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

    private(set) var uvIndex: UVIndexModel?
    public private(set) var weather: Weather?
    
    private var cancellables = Set<AnyCancellable>()
    
    public init(endPoint: OpenWeatherEndPoints) {
        self.fetchData(
            from: URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=42&lon=21.43&exclude=alerts,minutely&appid=1401ad6496ff98b6401caab2e6cfa2d7")!,
            decodeTo: Weather.self) {[weak self] value in
            self?.weather = value
            self?.state = .success
        }
//        self.locationManager.coordinates.sink {[weak self] coordinates in
//            self?.fetchUVIndex(from: endPoint, coordinates: coordinates)
//        }.store(in: &cancellables)
    }
   
}

extension OpenWeatherService {
    
    func fetchUVIndex(from: OpenWeatherEndPoints, coordinates: CLLocationCoordinate2D) {
        var components = URLComponents(url: from.url, resolvingAgainstBaseURL: true)
        components?.appendQueryItems(
            [
                "lat" : String(coordinates.latitude),
                "lon" : String(coordinates.longitude),
                "appid" : "1401ad6496ff98b6401caab2e6cfa2d7"
            ]
        )
        guard let url = components?.url else { return }
        self.fetchData(from: url, decodeTo: UVIndexModel.self) {[weak self] value in
            self?.uvIndex = value
            self?.state = .success
        }
    }
}

extension OpenWeatherService {
    
    func fetchWeather(from endPoint: OpenWeatherEndPoints, coordinates: CLLocationCoordinate2D) {
//        var components = URLComponents(url: endPoint.url, resolvingAgainstBaseURL: true)
//        components?.appendQueryItems(
//            [
//                "lat" : String(coordinates.latitude),
//                "lon" : String(coordinates.longitude),
//                "appid" : "1401ad6496ff98b6401caab2e6cfa2d7"
//            ]
//        )
//        guard let url = components?.url else { return }
        self.fetchData(
            from: URL(string: "http://api.openweathermap.org/data/2.5/forecast?q=skopje&appid=1401ad6496ff98b6401caab2e6cfa2d7")!,
            decodeTo: Weather.self) {[weak self] value in
            self?.weather = value
            self?.state = .success
        }
    }
}

extension OpenWeatherService {
    
    private func fetchData<T>(from url: URL, decodeTo: T.Type, completion: @escaping((T) -> Void)) where T: Codable{
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
