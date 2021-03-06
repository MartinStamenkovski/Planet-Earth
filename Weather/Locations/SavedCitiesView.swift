//
//  SavedLocations.swift
//  Weather
//
//  Created by Martin Stamenkovski on 8.12.20.
//

import SwiftUI
import OpenWeatherAPI
import CoreLocation
import Helpers
import CoreData
import PEDatabase

public struct SavedCitiesView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext

    @FetchRequest(
        entity: City.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \City.name, ascending: true)],
        animation: Animation.spring()
    ) var cities: FetchedResults<City>
                
    @State private var showSearchCity = false
    
    let currentLocation: Placemark?
    let onCitySelected: ((Placemark) -> Void)

    public init(currentLocation: Placemark?, onCitySelected: @escaping ((Placemark) -> Void)) {
        self.currentLocation = currentLocation
        self.onCitySelected = onCitySelected
    }
    
    public var body: some View {
        NavigationView {
            VStack {
                List {
                    if let currentLocation = self.currentLocation {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(currentLocation.name ?? "")
                            Text("My Location")
                                .font(.system(size: 13))
                                .foregroundColor(Color(.secondaryLabel))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.onCitySelected(currentLocation)
                        }
                    }
                    ForEach(cities) { city in
                        HStack {
                            SavedCityRow(city: city)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            let placemark = Placemark(from: city)
                            self.onCitySelected(placemark)
                        }
                    }.onDelete(perform: removeCities(at:))
                }
                .listStyle(PlainListStyle())
                .navigationBarTitle(Text("Saved Locations"))
                .navigationBarItems(trailing: trailingBarButtons())
            }.sheet(isPresented: $showSearchCity, content: {
                SearchLocationView(isShown: $showSearchCity) { placemark in
                    self.saveNewCity(from: placemark)
                }
            })
        }.navigationViewStyle(StackNavigationViewStyle())
       
    }
    
    private func trailingBarButtons() -> some View {
        Button {
            self.showSearchCity = true
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 22))
        }
    }
    
    private func saveNewCity(from placemark: Placemark) {
        let newCity = City(context: managedObjectContext)
        newCity.name = placemark.name
        newCity.country = placemark.country
        newCity.latitude = placemark.coordinate.latitude
        newCity.longitude = placemark.coordinate.longitude
        NSPersist.shared.save(context: managedObjectContext)
    }
    
    private func removeCities(at offset: IndexSet) {
        for index in offset {
            self.managedObjectContext.delete(cities[index])
        }
        NSPersist.shared.save(context: managedObjectContext)
    }
}

struct SavedLocations_Previews: PreviewProvider {
    static var previews: some View {
        SavedCitiesView(currentLocation: nil, onCitySelected: { _ in })
    }
}

struct SavedCityRow: View {
    
    let city: City
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(city.name ?? "")
            Text(city.country ?? "")
                .font(.system(size: 13))
                .foregroundColor(Color(.secondaryLabel))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
