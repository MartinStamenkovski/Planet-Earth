//
//  SearchCityView.swift
//  Weather
//
//  Created by Martin Stamenkovski on 11.12.20.
//

import SwiftUI
import OpenWeatherAPI
import SupportingViews

struct SearchCityView: View {
    @Binding var isShown: Bool
    public let onCitySelected: ((Placemark) -> Void)
    
    private var locationManager = LocationManager()
    
    @State private var textChanged: String = ""
    @State private var focused: Bool = true
    
    @State private var cities: [Placemark] = []
    
    public init(isShown: Binding<Bool>, onCitySelected: @escaping ((Placemark) -> Void)) {
        self._isShown = isShown
        self.onCitySelected = onCitySelected
    }
    
    public var body: some View {
        NavigationView {
            VStack {
                SearchBar(self.$textChanged, focusChanged: $focused, focusDelay: 0.3) { query in
                    self.searchBarTextChanged(query)
                }.padding(.horizontal, 6)
                List {
                    ForEach(cities) { placemark in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(placemark.name ?? "")
                            Text(placemark.country ?? "")
                                .font(.system(size: 13))
                                .foregroundColor(Color(.secondaryLabel))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.isShown = false
                            self.onCitySelected(placemark)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarTitle(Text("Cities"))
            .navigationBarItems(trailing: trailingBarButtons())
            .navigationBarHidden(focused)
            .animation(.easeInOut)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func searchBarTextChanged(_ query: String) {
        if query.isEmpty {
            self.cities = []
            return
        }
        self.locationManager.searchPlace(with: query) { cities in
            self.cities = cities
        }
    }
    
    func trailingBarButtons() -> some View {
        Button {
            self.isShown = false
        } label: {
            Text("Done")
        }
    }
    
}

struct SearchCityView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCityView(isShown: .constant(false), onCitySelected: { _ in })
    }
}
