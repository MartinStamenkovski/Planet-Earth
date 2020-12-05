//
//  UVIndexView.swift
//  UVIndex
//
//  Created by Martin Stamenkovski on 4.12.20.
//

import SwiftUI
import OpenWeatherAPI

public struct UVIndexView: View {
    
    @ObservedObject var service = OpenWeatherService(endPoint: .uvIndex)
    
    public init() { }
    
    public var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                .padding()
            }.navigationBarTitle(Text("UV Index"))
        }
    }
}

struct ProgressView: View {
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 1)
                .stroke(style: StrokeStyle(lineWidth: 8.0, lineCap: .round, lineJoin: .round))
                .opacity(0.6)
                .foregroundColor(Color.blue)
            Circle()
                .trim(from: 0, to: min(0.5, 1))
                .stroke(style: StrokeStyle(lineWidth: 8.0, lineCap: .round, lineJoin: .round))
                .rotationEffect(Angle(degrees: 270))
                .foregroundColor(Color.green)
                .background(
                    Circle()
                        .fill(Color.red)
                        .padding(4.0)
                )
            Text("1.4")
                .font(.system(size: 30, weight: .bold))
                .lineLimit(1)
                .padding([.leading, .trailing], 3)
        }.frame(width: 250, height: 250)
    }
}
struct UVIndexView_Previews: PreviewProvider {
    static var previews: some View {
        UVIndexView()
    }
}
