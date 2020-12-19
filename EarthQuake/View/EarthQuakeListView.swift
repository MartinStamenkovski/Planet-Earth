//
//  EarthQuakeView.swift
//  EarthQuake
//
//  Created by Martin Stamenkovski on 21.11.20.
//

import SwiftUI
import Helpers
import Extensions

public struct EarthQuakeListView: View {
    
    @ObservedObject private var service = EarthQuakeService()
    
    public init() { }
    
    public var body: some View {
        NavigationView {
            self.contentView()
                .navigationBarTitle(Text("Earthquakes"))
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func contentView() -> AnyView {
        switch service.state {
        case .loading:
            return ActivityIndicator(.constant(true), color: .systemBlue).toAnyView()
        case .error(let error):
            return PEErrorView(error: error) {
                self.service.fetchEarthQuakes()
            }.toAnyView()
        default:
            return QuakesListView(
                quakesTimeline: self.service.quakesTimeline,
                selectedCountry: self.service.selectedCountry,
                countryChanged: { country in
                self.service.fetchEarthQuakes(for: country)
            }).toAnyView()
        }
    }
    
}

struct QuakesListView: View {
    
    @State private var showCountryPicker = false

    let quakesTimeline: [QuakeTimeline]
    let selectedCountry: Country?
    let countryChanged: ((Country) -> Void)
    
    var body: some View {
        List {
            ForEach(quakesTimeline, id: \.id) { timeline in
                Section(header: Text(timeline.time)) {
                    ForEach(timeline.quakes, id: \.id) { quake in
                        NavigationLink(destination: EarthQuakesMapView(quakes, selected: quake)) {
                            QuakeRow(quake: quake)
                        }
                    }
                }
            }
        }
        .listStyle(PlainListStyle())
        .navigationBarItems(leading: leadingBarButtons())
        .sheet(isPresented: self.$showCountryPicker, content: {
            CountryPickerView(isShown: $showCountryPicker, selectedCountry: selectedCountry) { country in
                self.countryChanged(country)
            }
        })
    }
    
    var quakes: [Quake] {
        return quakesTimeline.flatMap { $0.quakes }
    }
    
    func leadingBarButtons() -> some View {
        Button {
            self.showCountryPicker.toggle()
        } label: {
            Image(systemName: "slider.vertical.3")
                .font(.system(size: 20))
        }
    }
}

struct EarthQuakeListView_Previews: PreviewProvider {
    static var previews: some View {
        EarthQuakeListView()
    }
}
