//
//  CountryPickerRow.swift
//  CountryPicker
//
//  Created by Martin Stamenkovski on 1.12.20.
//

import SwiftUI
import KingfisherSwiftUI

struct CountryPickerRow: View {
    let country: Country
    let isSelected: Bool
    let onCountrySelected: ((Country) -> Void)
    
    var body: some View {
        HStack {
            if let flagURL = country.flagURL {
                KFImage(URL(string: "https:\(flagURL)"))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 20)
            }
            Text(country.name)
            if isSelected {
                Spacer()
                Image(systemName: "checkmark")
                    .font(.system(size: 15))
                    .foregroundColor(Color.blue)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
        .onTapGesture {
            self.onCountrySelected(country)
        }
    }
}


