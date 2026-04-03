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
