//
//  CountryPickerRow.swift
//  CountryPicker
//
//  Created by Martin Stamenkovski on 1.12.20.
//

import SwiftUI
import KingfisherSwiftUI

struct CountryPickerRow: View {
    var country: Country
    var selectedCountry: ((Country) -> Void)
    
    var body: some View {
        HStack {
            if let flagURL = country.flagURL {
                KFImage(URL(string: "https:\(flagURL)"))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 20)
            }
            Text(country.name)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
        .onTapGesture {
            self.selectedCountry(country)
        }
    }
}


