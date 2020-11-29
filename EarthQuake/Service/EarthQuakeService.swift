//
//  EarthQuakeService.swift
//  EarthQuake
//
//  Created by Martin Stamenkovski on 21.11.20.
//

import Foundation
import SwiftSoup
import SwiftUI
import Combine
import Extensions
import CoreLocation

public enum LoadingState {
    case loading
    case success
    case error(Error)
}

class EarthQuakeService: ObservableObject {
    
    private let earthQuakesURL = URL(string: "https://www.volcanodiscovery.com/earthquakes/today-showMore.html")!
    
    @Published private(set) var quakesTimeline: [QuakeTimeline] = []
    @Published private(set) var state = LoadingState.loading
    
    
    private var task: AnyCancellable?
    
    init() {
        self.fetchEarthQuakes()
    }
    
    func fetchEarthQuakes() {
        self.state = .loading
        self.task = URLSession.shared.dataTaskPublisher(for: earthQuakesURL)
            .compactMap { String(data: $0.data, encoding: .utf8) }
            .tryMap { data -> [QuakeTimeline] in
                return try self.parseEarthQuakesHtmlTable(from: data)
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { failure in
                switch failure {
                case .failure(let error):
                    self.state = .error(error)
                    break
                default:
                    break
                }
            }, receiveValue: { value in
                self.quakesTimeline = value
                self.state = .success
            })
        
    }
    
    private func parseEarthQuakesHtmlTable(from data: String) throws -> [QuakeTimeline] {
        let html = try SwiftSoup.parse(data)
        let quakeRows = try html.getElementById("qTable")?.select("tr").array().dropFirst()
        
        var earthQuakesTimeline: [QuakeTimeline] = []
        var currentEarthQuakeTimeline: QuakeTimeline?
        
        for row in quakeRows ?? [] {
            if !row.hasAttr("id") {
                if let timeline = currentEarthQuakeTimeline {
                    earthQuakesTimeline.append(timeline)
                }
                let dateTimeline = try row.select("td").text()
                    .replacingOccurrences(of: "(GMT)", with: "")
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                
                currentEarthQuakeTimeline = QuakeTimeline(time: dateTimeline)
            } else {
                currentEarthQuakeTimeline?.append(earthQuake: try quake(from: row))
            }
        }
        if let timeline = currentEarthQuakeTimeline {
            earthQuakesTimeline.append(timeline)
        }
        return earthQuakesTimeline
    }
    
    private func quake(from cell: Elements.Element) throws -> Quake {
        var quake = Quake()
        
        let dateElement = try cell.getElementsByClass("sl2")
        try dateElement.select("span").remove()
        let date = try dateElement.text()
            .replacingOccurrences(of: "GMT", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        let magnitudeAndDepthElement = try cell.getElementsByClass("mList")
        let magnitude = try magnitudeAndDepthElement.select("div").remove().text()
        let depth = try magnitudeAndDepthElement.text()
        
        quake.date = date.earthQuakeDate
        quake.time = quake.date?.shortTimeOnly()
        quake.timeAgo = quake.date?.timeAgo()
        
        quake.magnitude = magnitude
        quake.depth = depth.isEmpty ? "N/A" : depth
        
        quake.location = try self.quakeLocation(from: cell)
        return quake
    }
    
    private func quakeLocation(from cell: Elements.Element) throws -> QuakeLocation {
        var location = QuakeLocation()
        
        let locationElement = try cell.getElementsByClass("list_region")
        location.flag = try locationElement.select("img").attr("src")
        let country = try locationElement.select("img").attr("title")
        location.country = country.isEmpty ? "N/A" : country
        
        location.detailInfo = try locationElement.select("a.sl").remove().attr("href")
        
        try locationElement.select("a").remove()
        
        let locationName = try locationElement.text()
            .replacingOccurrences(of: "-", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        location.name = locationName.isEmpty ? "N/A" : locationName
        
        let coordinates = try cell.getElementsByClass("smap").attr("onclick")
            .split(separator: "(")
            .last?
            .split(separator: ",")
            .prefix(2)
            .compactMap { Double($0) }
        
        if let coordinates = coordinates {
            location.coordinates = CLLocationCoordinate2D(latitude: coordinates[0], longitude: coordinates[1])
        }
        return location
    }
  
}


