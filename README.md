 # Segmented Picker for WatchOS

<p align="center">
</p>
![SegmentedPickerDemo](https://github.com/caleb-mccreary/WatchOS-SegmentedPicker/assets/17240610/b14462d3-d3ee-4f4f-b999-77e88d6b358a)

### Summary
[Pickers](https://developer.apple.com/documentation/swiftui/picker) are controls for allowing user selection from a set of mutually exclusive options. 
While SwiftUI pickers are available in watchOS, the segmented variant (shown below) is not.
<p align="center">
  <Img src="https://docs-assets.developer.apple.com/published/98a60cede646d5cd2342c8d68c01b1b3/Picker-3-iOS~dark@2x.png">
</p>
 
This repository includes a custom built segmented picker for usage in watchOS as well as an interactive demo.

### How to Use It
The component re-uses the paradigm 

### Design
Segmented pickers are challenging in watchOS primarily due to the highly constrained horizontal surface. Even with just a couple of options, text-based selections
readily overflow and end up truncated. Since we lack hover context on a touch surface, it's not tenable to be obscuring this information.

Because of this, I opted for a design that limits the picker to `.iconOnly` labes as selections. Icons, especially systemImages, readily convey their information
with a grealtly reduced surface footprint. 

The picker can comfortably 4 selections with 5 (<= 41mm) and 6 (>= 45mm) being possible depending on screen size.
<p align="center">
  <img width="300" alt="SegmentedPickerPreview" src="https://github.com/caleb-mccreary/WatchOS-SegmentedPicker/assets/17240610/a081ab88-b1f8-445b-ad29-608d78c27e41">
</p>
