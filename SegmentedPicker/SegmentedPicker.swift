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
            case backward
            case forward
        }
        
        @State var play = Status.play
        @State var pause = Status.pause
        @State var backward = Status.backward
        
        var selections = Status.allCases.map { status in
            switch(status) {
            case .play:
                return Selection(label: "Play", systemImage: "play", value: status)
            case .pause:
                return Selection(label: "Pause", systemImage: "pause", value: status)
            case .forward:
                return Selection(label: "Forward", systemImage: "forward", value: Status.forward)
            case .backward:
                return Selection(label: "Forward", systemImage: "backward", value: Status.backward)
            }
        }
        
        var body: some View {
            VStack(spacing: 16) {
                SegmentedPicker(selectionValue: $play, selections: selections.dropLast(2))
                SegmentedPicker(selectionValue: $pause, selections: selections.dropLast(1))
                SegmentedPicker(selectionValue: $backward, selections: selections)
            }
        }
    }
    
    return Wrapper()
}
