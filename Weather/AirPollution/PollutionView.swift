//
//  PollutionView.swift
//  Weather
//
//  Created by Martin Stamenkovski on 20.12.20.
//

import SwiftUI
import OpenWeatherAPI
import Helpers

public struct PollutionView: View {
    
    @ObservedObject var weatherService = OpenWeatherService(endPoint: .airPollution)

    public init() { }
    
    public var body: some View {
        NavigationView {
            VStack {
                contentView()
            }.navigationBarTitle(Text("Air Quality"))
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func contentView() -> AnyView {
        switch weatherService.state {
        case .success:
            return self.scrollView()
        case .error(let error):
            return self.showErrorView(for: error)
        case .loading:
            return ActivityIndicator(.constant(true), color: .systemBlue).toAnyView()
        }
    }
    
    private func scrollView() -> AnyView {
        if let currentPollution = self.weatherService.currentPollution?.pollutionElements.first,
           let pollutionForecast = self.weatherService.pollutionForecast {
            return ScrollView(showsIndicators: false) {
                VStack {
                    MainPollutionView(pollution: currentPollution)
                    Divider()
                    GassesView(gasses: currentPollution.components)
                    Divider()
                    PollutionForecastView(pollution: pollutionForecast)
                }
            }.toAnyView()
        } else {
            return PEErrorView(error: .message("No data available")) {
                
            }.toAnyView()
        }
    }
    
    private func showErrorView(for error: PEError) -> AnyView  {
        NavigationView {
            PEErrorView(error: error) {
                //self.weatherService.retryWeatherRequest()
            }
        }.toAnyView()
    }
}

struct PollutionView_Previews: PreviewProvider {
    static var previews: some View {
        PollutionView()
    }
}

struct PollutantDetail: View {
    let title: String
    let value: Double
    
    var body: some View {
        VStack(spacing: 4) {
            Text("\(value, specifier: "%.1f")")
                .font(.system(size: 20))
                .bold()
            Text(title)
                .font(.system(size: 13, weight: .thin))
        }.frame(minWidth: 0, maxWidth: .infinity)
    }
}
