//
//  GasRow.swift
//  Weather
//
//  Created by Martin Stamenkovski on 26.12.20.
//

import SwiftUI

struct GasRow: View {
    let gasType: String
    let gasValue: Double
    
    var body: some View {
        HStack(spacing: 8) {
            Text(gasType.replacingOccurrences(of: "_", with: ".").uppercased())
                .font(.system(size: 17, weight: .medium))
            Spacer()
            HStack(spacing: 6) {
                Text("\(gasValue, specifier: "%.2f")")
                    .font(.system(size: 17, weight: .heavy))
                Text("μg/m3")
                    .font(.system(size: 17))
            }
        }
        .padding(8)
    }
}

struct GasRow_Previews: PreviewProvider {
    static var previews: some View {
        GasRow(gasType: "PM 10", gasValue: 2)
    }
}
