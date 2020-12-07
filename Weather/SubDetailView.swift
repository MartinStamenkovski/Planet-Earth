//
//  SubDetailView.swift
//  Weather
//
//  Created by Martin Stamenkovski on 5.12.20.
//

import SwiftUI


struct SubDetailView: View {
    
    let imageName: String
    let title: String
    let data: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Image(systemName: imageName)
                .scaledToFit()
                .font(.system(size: 20))
            Spacer(minLength: 8)
            VStack(spacing: 3) {
                Text(title)
                    .font(.system(size: 12, weight: .semibold))
                Text(data)
                    .font(.system(size: 12, weight: .light))
            }
        }
    }
}
