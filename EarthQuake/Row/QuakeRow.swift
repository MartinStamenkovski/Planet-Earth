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
            HStack(spacing: 12) {
                QuakeTimeView(quake: quake)
                Text(quake.magnitude ?? "N/A")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(quake.magnitudeColor)
                    .fixedSize()
                    .frame(width: 32)
            }
        }
    }
}

struct QuakeLocationView: View {
    var location: QuakeLocation?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                KFImage(location?.flagURL)
                    .cancelOnDisappear(true)
                    .resizable()
                    .frame(width: 16, height: 11)
                
                Text(location?.country ?? "N/A")
                    .font(.system(size: 17))
            }
            Text(location?.name ?? "N/A")
                .font(.system(size: 13))
                .foregroundColor(Color.secondary)
        }
    }
    
}

struct QuakeTimeView: View {
    var quake: Quake
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 5) {
            Text(quake.time ?? "N/A")
                .font(.system(size: 13))
            Text(quake.timeAgo ?? "N/A")
                .font(.system(size: 10))
                .foregroundColor(.secondary)
        }
    }
}

struct QuakeRow_Previews: PreviewProvider {
    static var previews: some View {
        QuakeRow(quake: .init())
    }
}
