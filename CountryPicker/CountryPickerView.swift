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
    @State private var query: String = ""
    
    @Binding var isShown: Bool
    
    private var onCountrySelected: ((Country) -> Void)
    private var selectedCountry: Country?
    
    public init(isShown: Binding<Bool>, selectedCountry: Country?, onCountrySelected: @escaping ((Country) -> Void)) {
        self._isShown = isShown
        self.onCountrySelected = onCountrySelected
        self.selectedCountry = selectedCountry
    }
    
    public var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass").foregroundColor(.gray)
                    TextField("Search country", text: $query)
                }
                .padding(8)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.8), lineWidth: 0.8))
                .padding(12)
                List {
                    Section(header: Text("Area")) {
                        WorldWideRow(
                            isShown: self.$isShown,
                            isSelected: selectedCountry?.isToday ?? false,
                            onCountrySelected: onCountrySelected
                        )
                        NavigationLink(destination: USAStatesView(
                            isShown: $isShown,
                            selectedState: selectedCountry,
                            onCountrySelected: onCountrySelected
                        )) {
                            Text("United States")
                        }
                    }
                    Section(header: Text("Countries")) {
                        ForEach(countries.filter { query.isEmpty ? true : $0.name.lowercased().contains(query.lowercased()) }, id: \.id) { country in
                            CountryPickerRow(country: country, isSelected: selectedCountry == country) { selectedCountry in
                                self.isShown = false
                                self.onCountrySelected(selectedCountry)
                            }
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

private struct WorldWideRow: View {
    
    @Binding var isShown: Bool
    
    let isSelected: Bool
    let onCountrySelected: ((Country) -> Void)
    
    var body: some View {
        HStack {
            Text("Worldwide")
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    self.isShown = false
                    self.onCountrySelected(Country(name: "today"))
                }
            if isSelected {
                Spacer()
                Image(systemName: "checkmark")
                    .font(.system(size: 15))
                    .foregroundColor(Color.blue)
            }
        }
    }
}
struct CountryPickerView_Previews: PreviewProvider {
    static var previews: some View {
        CountryPickerView(isShown: .constant(true), selectedCountry: nil, onCountrySelected: { _ in })
    }
}
