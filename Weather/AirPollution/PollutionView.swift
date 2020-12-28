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
    
    @ObservedObject var weatherService = OpenWeatherService<(Pollution, Pollution)>(endPoint: .airPollution)

    @State private var showLocationSearch = false
    
    public init() { }
    
    public var body: some View {
        NavigationView {
            VStack {
                contentView()
            }
            .navigationBarTitle(Text("Air Quality"))
            .navigationBarItems(trailing: trailingBarButtons())
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func contentView() -> AnyView {
        switch weatherService.state {
        case .success((let pollution, let forecast)):
            return self.configureScrollView(for: pollution, forecast: forecast)
        case .error(let error):
            return self.showErrorView(for: error)
        case .loading:
            return ActivityIndicator(.constant(true), color: .systemBlue).toAnyView()
        }
    }
    
    private func configureScrollView(for pollution: Pollution, forecast: Pollution) -> AnyView {
        if let pollutionElement = pollution.pollutionElements.first {
            return ScrollView(showsIndicators: false) {
                VStack {
                    MainPollutionView(pollution: pollutionElement, placemark: weatherService.selectedPlacemark)
                    Divider()
                    GassesView(gasses: pollutionElement.components)
                    Divider()
                    PollutionForecastView(pollution: forecast)
                }
            }.toAnyView()
        }
        return self.showErrorView(for: .message("No data available"))
    }
    
    private func showErrorView(for error: PEError) -> AnyView  {
        PEErrorView(error: error) {
            self.weatherService.retryAirPollutionRequest()
        }.toAnyView()
    }
    
    private func trailingBarButtons() -> some View {
        return Button {
            self.showLocationSearch.toggle()
        } label: {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 20))
        }.sheet(isPresented: $showLocationSearch) {
            SearchLocationView(isShown: $showLocationSearch) { placemark in
                self.weatherService.fetchAirPollution(for: placemark)
            }
        }
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
