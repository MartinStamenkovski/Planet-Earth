//
//  USAStatesView.swift
//  CountryPicker
//
//  Created by Martin Stamenkovski on 1.12.20.
//

import SwiftUI

struct USAStatesView: View {
    
    @State private var states: [Country] = []
    
    @Binding var isShown: Bool
    private var onCountrySelected: ((Country) -> Void)
    
    public init(isShown: Binding<Bool>, onCountrySelected: @escaping ((Country) -> Void)) {
        self._isShown = isShown
        self.onCountrySelected = onCountrySelected
    }
    var body: some View {
        List {
            ForEach(states, id: \.id) { state in
                CountryPickerRow(country: state, isSelected: false) { selectedCountry in
                    self.isShown = false
                    self.onCountrySelected(selectedCountry)
                }
            }
        }
        .navigationBarTitle(Text("Select State"))
        .onAppear {
            self.loadStates()
        }
    }
    
    private func loadStates() {
        let currentBundle = Bundle(identifier: "com.stamenkovski.CountryPicker")!
        let countriesJSON = currentBundle.url(forResource: "usa.json", withExtension: nil)!
        do {
            let data = try Data(contentsOf: countriesJSON, options: [])
            self.states = try JSONDecoder().decode([Country].self, from: data)
        } catch {
            
        }
    }
}

