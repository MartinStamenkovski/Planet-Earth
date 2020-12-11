//
//  WeatherIconModifier.swift
//  Weather
//
//  Created by Martin Stamenkovski on 11.12.20.
//

import SwiftUI

struct WeatherIconBackground: ViewModifier {
    @Environment(\.colorScheme) var colorScheme

    func body(content: Content) -> some View {
        content
            .background(
                Color(red: 78/255, green: 128/255, blue: 222/255, opacity: 1)
            )
            .clipShape(Circle())
    }
}
