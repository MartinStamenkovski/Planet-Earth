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
import Helpers

class EarthQuakeService: ObservableObject {
    
    private var earthQuakesURL: URL!
    
    private(set) var quakesTimeline: [QuakeTimeline] = []
    @Published private(set) var state = ViewState.loading
    
    private(set) var selectedCountry: Country!
    
    private var task: AnyCancellable?
    
    init() {
        self.fetchEarthQuakes()
    }
    
    func fetchEarthQuakes(for country: Country = Country(name: "today")) {
        self.selectedCountry = country
        self.earthQuakesURL = URL(string: "https://www.volcanodiscovery.com/earthquakes/\(country.quakeQueryName)-showMore.html")
        self.state = .loading
        self.task = URLSession.shared.dataTaskPublisherWithError(for: earthQuakesURL)
            .compactMap { String(data: $0, encoding: .utf8) }
            .tryCompactMap({[weak self] html -> [QuakeTimeline]? in
                return try self?.parseEarthQuakesHtmlTable(from: html)
            })
            .receive(on: RunLoop.main)
            .sink({[weak self] result in
                switch result {
                case .failure(let error):
                    self?.state = .error(.message(error.localizedDescription))
                    break
                case .success(let timeline):
                    self?.quakesTimeline = timeline
                    self?.state = .success
                    break
                }
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
                guard try row.attr("id").contains("quake") else { continue }
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
        
        let dateElement = try cell.select("td").first()
        var quakeDate: Date?
        if self.selectedCountry.name == "today" {
            try dateElement?.select("span").remove()

            quakeDate = try dateElement?.text()
                .replacingOccurrences(of: "GMT", with: "")
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .earthQuakeDate
        } else {
            quakeDate = try dateElement?.select("span[class=subdued]").text()
                .replacingOccurrences(of: "[GMT()]", with: "", options: .regularExpression)
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .earthQuakeDate
            //When quake date is empty than subdued does not exist, that most of the time means
            // the date is in the <a> tag which we are extracting here.
            if quakeDate == nil {
                try dateElement?.select("span").remove()
                quakeDate = try dateElement?.text()
                    .replacingOccurrences(of: "GMT", with: "")
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                    .earthQuakeDate
            }
        }
        
        let magnitudeAndDepthElement = try cell.getElementsByClass("mList")
        let magnitude = try magnitudeAndDepthElement.select("div").remove().text()
        let depth = try magnitudeAndDepthElement.text()
        
        quake.date = quakeDate
        quake.time = quake.date?.shortTimeOnly
        quake.timeAgo = quake.date?.timeAgo
        
        quake.magnitude = magnitude
        quake.depth = depth.isEmpty ? "N/A" : depth
        
        quake.location = try self.quakeLocation(from: cell)
        return quake
    }
    
    private func quakeLocation(from cell: Elements.Element) throws -> QuakeLocation {
        var location = QuakeLocation()
        
        let locationElement = try cell.getElementsByClass("list_region")
        let countryFlag = try locationElement.select("img").attr("src")
        if countryFlag.isEmpty, let flagURL = selectedCountry.flagURL {
            location.flag = "https:\(flagURL)"
        } else {
            location.flag = "https://www.volcanodiscovery.com/\(countryFlag)"
        }
        let country = try locationElement.select("img").attr("title")
        
        if country.isEmpty && self.selectedCountry.name != "today" {
            location.country = self.selectedCountry.name.replacingOccurrences(of: "-", with: " ").firstUppercased
        } else {
            location.country = country.isEmpty ? "N/A" : country
        }
        
        location.detailInfo = try locationElement.select("a.sl").remove().attr("href")
        
        try locationElement.select("a[href=#]").remove()
        
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


