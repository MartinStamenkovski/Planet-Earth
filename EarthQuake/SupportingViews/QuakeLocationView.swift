//
//  QuakeLocationView.swift
//  EarthQuake
//
//  Created by Martin Stamenkovski on 22.12.20.
//

import SwiftUI
import KingfisherSwiftUI

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
