//
//  ContentView.swift
//
//  Created by Caleb McCreary on 4/13/24.
//

import SwiftUI

struct ContentView: View {
    private enum Weather: CaseIterable {
        case sunny
        case stormy
        case windy
        
        var selection: Selection<Weather> {
            switch(self) {
            case .sunny:
                return Selection(label: "Sunny", systemImage: "sun.horizon", value: self)
            case .stormy:
                return Selection(label: "Stormy", systemImage: "cloud.bolt.rain", value: self)
            case .windy:
                return Selection(label: "Windy", systemImage: "wind.snow", value: self)
            }
        }
    }
    
    @State private var selectionValue = Weather.sunny
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: selectionValue.selection.systemImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .transition(.asymmetric(
                    insertion: .offset(x: -200),
                    removal: .offset(x: 200)
                ))
                .id(selectionValue.selection.id)
            
            Spacer()
            
            SegmentedPicker(selectionValue: $selectionValue) {
                Weather.allCases.map { weather in
                    weather.selection
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
