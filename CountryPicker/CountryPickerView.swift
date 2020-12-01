//
//  CountryPickerView.swift
//  CountryPicker
//
//  Created by Martin Stamenkovski on 29.11.20.
//

import SwiftUI
import KingfisherSwiftUI

public struct CountryPickerView: View {
    
    @State private var countries: [Country] = []
    
    @Binding var isShown: Bool
    private var countrySelectionChanged: ((Country) -> Void)
    
    public init(isShown: Binding<Bool>, countrySelectionChanged: @escaping ((Country) -> Void)) {
        self._isShown = isShown
        self.countrySelectionChanged = countrySelectionChanged
    }
    
    public var body: some View {
        NavigationView {
            List {
                Section(header: Text("Area")) {
                    Text("Worldwide")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.isShown = false
                            self.countrySelectionChanged(Country(name: "today"))
                        }
                    NavigationLink(destination: USAStatesView(isShown: $isShown, selectionChanged: countrySelectionChanged)) {
                        Text("United States")
                    }
                }
                Section(header: Text("Countries")) {
                    ForEach(countries, id: \.id) { country in
                        CountryPickerRow(country: country) { selectedCountry in
                            self.isShown = false
                            self.countrySelectionChanged(selectedCountry)
                        }
                    }
                }
            }
            .navigationBarItems(trailing: trailingBarButtons())
            .navigationBarTitle(Text("Select Country"))
        }.onAppear {
            self.loadCountries()
        }
    }
    
    private func loadCountries() {
        let currentBundle = Bundle(identifier: "com.stamenkovski.CountryPicker")!
        let countriesJSON = currentBundle.url(forResource: "countries.json", withExtension: nil)!
        do {
            let data = try Data(contentsOf: countriesJSON, options: [])
            self.countries = try JSONDecoder().decode([Country].self, from: data)
        } catch {
            
        }
    }
    
    private func trailingBarButtons() -> some View {
        Button(action: {
            self.isShown = false
        }, label: {
            Text("Done")
        })
    }
}

struct CountryPickerView_Previews: PreviewProvider {
    static var previews: some View {
        CountryPickerView(isShown: .constant(true), countrySelectionChanged: { _ in })
    }
}
