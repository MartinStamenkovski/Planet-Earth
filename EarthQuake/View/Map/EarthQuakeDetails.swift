//
//  EarthQuakeDetails.swift
//  EarthQuake
//
//  Created by Martin Stamenkovski on 26.11.20.
//

import SwiftUI
import KingfisherSwiftUI
import Extensions

struct EarthQuakeDetails: View {
    var quake: Quake
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 6) {
            if let location = quake.location {
                HStack {
                    QuakeLocationDetail(location: location)
                    Spacer()
                    Text(quake.magnitude ?? "N/A")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color(quake.magnitudeColor))
                }
            }
            Divider()
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    QuakeSubDetail(key: "Depth:", value: quake.depth)
                    if let coordinates = quake.location?.coordinates {
                        Spacer()
                        Text("\(coordinates.latitude), \(coordinates.longitude)")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(Color(.label))
                    }
                }.frame(height: 20)
                Divider()
                HStack {
                    QuakeSubDetail(key: "Date:", value: quake.date?.earthQuakeDateToCurrentLocale)
                    if let timeAgo = quake.timeAgo {
                        Spacer()
                        Text(timeAgo)
                            .font(.system(size: 12, weight: .medium))
                    }
                }.frame(height: 20)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        .padding(.all, 8)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .shadow(color: Color(quake.magnitudeColor).opacity(0.5), radius: 3, x: 0, y: 2)
        .opacity(0.9)
    }
}

struct QuakeLocationDetail: View {
    var location: QuakeLocation
    var body: some View {
        HStack {
            KFImage(location.flagURL)
                .resizable()
                .scaledToFit()
                .frame(width: 16, height: 11)
            VStack(alignment: .leading, spacing: 5) {
                Text(location.country ?? "N/A")
                    .font(.system(size: 15, weight: .bold))
                    .lineLimit(1)
                Text(location.name ?? "N/A")
                    .font(.system(size: 11))
                    .lineLimit(1)
            }
        }
    }
}

struct QuakeSubDetail: View {
    var key: String
    var value: String?
    
    var body: some View {
        HStack {
            
            Text(key)
                .font(.system(size: 12))
                .foregroundColor(Color(.secondaryLabel))
            Text("\(value ?? "N/A")")
                .lineLimit(1)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(Color(.label))
        }
    }
}

//struct EarthQuakeDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        EarthQuakeDetails(quake: nil)
//    }
//}
