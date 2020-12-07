//
//  UVIndexView.swift
//  Weather
//
//  Created by Martin Stamenkovski on 6.12.20.
//

import SwiftUI

struct UVIndexView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 12) {
                Image(systemName: "sun.max")
                    .font(.system(size: 25))
                    .foregroundColor(Color.orange)
                HStack {
                    Text("1.8")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(Color.green)
                    Text("UV Index")
                        .font(.system(size: 20))
                        .foregroundColor(Color(.secondaryLabel))
                }
            }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            Text("Being outdoors is perfectly safe.")
                .font(.system(size: 17, weight: .medium))
        }.padding(8)
    }
}

struct UVIndexView_Previews: PreviewProvider {
    static var previews: some View {
        UVIndexView()
    }
}
