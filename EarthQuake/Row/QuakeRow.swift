//
//  QuakeRow.swift
//  EarthQuake
//
//  Created by Martin Stamenkovski on 21.11.20.
//

import SwiftUI
import KingfisherSwiftUI

struct QuakeRow: View {
    var quake: Quake
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 8) {
            QuakeLocationView(location: quake.location)
            Spacer()
            HStack(spacing: 10) {
                QuakeTimeView(quake: quake)
                Text(quake.magnitude ?? "N/A")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(Color(quake.magnitudeColor))
                    .frame(minWidth: 36)
            }
        }
    }
}

struct QuakeRow_Previews: PreviewProvider {
    static var previews: some View {
        QuakeRow(quake: .init())
    }
}
