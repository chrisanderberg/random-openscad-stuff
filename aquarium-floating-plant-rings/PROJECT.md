# PROJECT.md

## Overview
This project contains printable floating rings for aquarium plants. The rings
create a floating boundary while using a shaped cross-section intended to avoid
bridging during printing.

## Current shape
- `models/floating_plant_ring.scad` is the full ring.
- `models/angled_floating_plant_ring.scad` is the parameterized partial-ring
  variant.
- `lib/project/ring_profile.scad` contains the shared cross-section helpers used
  by both variants.
- Existing STL exports from the older workspace were copied into `exports/`.

## Design notes
- The key idea is a rotate-extruded cross-section with a rectangular base and
  triangular top.
- Shared ring-profile logic now lives in `lib/project/`, while `models/`
  remains the top-level tuning surface.

## Current implementation notes
- The full ring uses a rotate-extruded polygon cross-section with a rectangular
  base and triangular top peak centered over the wall thickness.
- The angled ring is built as an arc slice plus two radial sides, then cleaned
  with targeted difference and intersection volumes to keep the joins readable
  and printable.
- Cross-section tuning favors `cross_section_total_height` and `top_angle`
  rather than separate rectangle and triangle height inputs.

## Validation focus
- Validate buoyancy and print quality with small physical test prints before
  scaling to larger production diameters.
- Validate that wall thickness and shell choices produce waterproof prints in
  practice, not just visually clean CAD.
- Validate the angled ring cleanup volumes across common sweep angles such as
  90 degrees, 180 degrees, and any custom partial-ring values that get used.

## Carry-forward assumptions
- A 30 degree top angle is the current default balance between printability and
  material efficiency.
- The hollow shaped cross-section should provide the needed weight reduction
  without reintroducing flat bridging surfaces.
- A smaller ring can remain a parameter variation of the same geometry rather
  than a separate model family unless testing proves otherwise.
