//
//  SegmentedPicker.swift
//
//  Created by Caleb McCreary on 4/12/24.
//

import SwiftUI

struct Selection<Value>: Identifiable where Value: Hashable {
    var id: UUID { UUID() }
    
    var label: String
    var systemImage: String
    var value: Value
}

struct SegmentedPicker<SelectionValue>: View where SelectionValue: Hashable {
    @Binding var selectionValue: SelectionValue
    var selections: [Selection<SelectionValue>]
    
    init(selectionValue: Binding<SelectionValue>, selections: [Selection<SelectionValue>]) {
        self._selectionValue = selectionValue
        self.selections = selections
    }
    
    init(selectionValue: Binding<SelectionValue>, selections: () -> [Selection<SelectionValue>]) {
        self._selectionValue = selectionValue
        self.selections = selections()
    }
    
    var body: some View {
        let roundedRectangle = RoundedRectangle(cornerRadius: 8)
        
        HStack(spacing: 0) {
            ForEach(selections) { selection in
                let isSelected = selectionValue == selection.value
                
                Label(selection.label, systemImage: selection.systemImage)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .labelStyle(.iconOnly)
                    .background(isSelected ? Rectangle().fill(.tertiary) : nil)
                    .contentShape(roundedRectangle)
                    .onTapGesture {
                        withAnimation {
                            selectionValue = selection.value
                        }
                    }
            }
        }
        .background(roundedRectangle.fill(.quaternary))
        .clipShape(roundedRectangle)
        .frame(height: 32)
    }
}

#Preview {
    struct Wrapper: View {
        enum Status: CaseIterable {
            case play
            case pause
            case shuffle
            case loop
        }
        
        @State var play = Status.play
        @State var pause = Status.pause
        @State var shuffle = Status.shuffle
        @State var loop = Status.loop
        
        let selections = Status.allCases.map { status in
            switch(status) {
            case .play:
                return Selection(label: "Play", systemImage: "play", value: status)
            case .pause:
                return Selection(label: "Pause", systemImage: "pause", value: status)
            case .shuffle:
                return Selection(label: "Shuffle", systemImage: "shuffle", value: status)
            case .loop:
                return Selection(label: "Loop", systemImage: "repeat", value: status)
            }
        }
        
        var body: some View {
            VStack(spacing: 16) {
                SegmentedPicker(selectionValue: $play, selections: selections.dropLast(2))
                SegmentedPicker(selectionValue: $pause, selections: selections.dropLast(1))
                SegmentedPicker(selectionValue: $shuffle, selections: selections)
            }
        }
    }
    
    return Wrapper()
}
