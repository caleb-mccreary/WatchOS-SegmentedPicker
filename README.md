 # Segmented Picker for WatchOS

<p align="center">
 <Img src="https://github.com/caleb-mccreary/WatchOS-SegmentedPicker/blob/main/SegmentedPickerDemo.gif">
</p>

### Summary
[Pickers](https://developer.apple.com/documentation/swiftui/picker) are controls for allowing user selection from a set of mutually exclusive options. 
While SwiftUI pickers are available in watchOS, the segmented variant (shown below) is not.
 
This repository includes a custom built segmented picker for usage in watchOS as well as an interactive demo.

### How to Use It
The component must be provided a `@Binding` for managing the selection state and an array of `Selection` for rendering the content.
```
@Binding var selectionValue: <Selection: Hashable>
var selections: [Selection<SelectionValue>]
```

where `Selection` is 
```
struct Selection<Value>: Identifiable where Value: Hashable {
    var id: UUID { UUID() }
    
    var label: String
    var systemImage: String
    var value: Value
}
```

and `selections` is providable via named argument or closure `() -> [Selection<SelectionValue>]`
```
SegmentedPicker(selectionValue: $selectionValue, selections: selections)

SegmentedPicker(selectionValue: $selectionValue) {
   return Selection(...)
}
```

The choice to use a custom struct rather than ViewBuilder was a long and agonized decision. Ultimately, I landed on providing the struct
as it allowed for the most flexibility in terms of transforming varieties of data sources into Views.

For example, my initial use-case that inspired the construction of this component was rendering a segmented picker for an existing enum.
By using this custom struct, I can easily transform this enum into an array of selections with `CaseIterable`:
```
enum Status {
    case play
    case pause
}

var selections = Status.allCases.map { status in
    switch(status) {
    case .paused:
        return Selection(label: "Play", systemImage: "play", value: status)
    case .play:
        return Selection(label: "Paused", systemImage: "pause", value: status)
    }
}
```

And this can be taken even further by defining a `var selection: Selection<Enum>` on the enum or other strucutred data itself :
```
enum Status {
    case play
    case pause

    var selection: Selection<Status> {
        switch(self) {
        case .play:
            return Selection(label: "Play", systemImage: "play", value: status)
        case .pause:
            return Selection(label: "Pause", systemImage: "pause", value: status)
        }
    }
}

SegmentedPicker(selectionValue: $selectionValue) {
    Status.allCases.map {
        $0.selection
    }
}
```

### Design
Segmented pickers are challenging in watchOS primarily due to the highly constrained horizontal surface. Even with just a couple of options, text-based selections
readily overflow and end up truncated. Since we lack hover context on a touch surface, it's not tenable to be obscuring this information.

Because of this, I opted for a design that limits the picker to `.iconOnly` labes as selections. Icons, especially systemImages, readily convey their information
with a grealtly reduced surface footprint. 

The picker can comfortably 4 selections with 5 (<= 41mm) and 6 (>= 45mm) being possible depending on screen size.
<p align="center">
  <img width="300" src="https://github.com/caleb-mccreary/WatchOS-SegmentedPicker/blob/main/SegmentedPickerPreview.png">
</p>
