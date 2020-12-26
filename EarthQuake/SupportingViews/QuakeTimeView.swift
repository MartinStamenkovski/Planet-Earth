//
//  QuakeTimeView.swift
//  EarthQuake
//
//  Created by Martin Stamenkovski on 22.12.20.
//

import SwiftUI


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
