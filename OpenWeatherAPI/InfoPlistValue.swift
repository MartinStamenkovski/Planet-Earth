//
//  InfoPlistValue.swift
//  OpenWeatherAPI
//
//  Created by Martin Stamenkovski on 30.12.20.
//

import Foundation

final class InfoPlistValue {
    fileprivate let OpenWeatherInfoKey = "OpenWeatherKey"

    private let bundle: Bundle!
    
    private init() {
        self.bundle = Bundle(for: type(of: self))
    }
    
    static let shared = InfoPlistValue()
    
    var openWeatherKey: String {
        return self.bundle.object(forInfoDictionaryKey: OpenWeatherInfoKey) as! String
    }
}
