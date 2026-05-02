# Floating Plant Rings

Printable floating rings for containing floating aquarium plants at the water
surface. The designs use a shaped cross-section with a rectangular base and
triangular top to avoid flat bridging surfaces during printing.

## Models

- `models/floating_plant_ring.scad` is the full-circle ring.
- `models/angled_floating_plant_ring.scad` is a parameterized partial-ring
  variant for quarter rings, half rings, or custom sweep angles.
- `lib/project/ring_profile.scad` contains the shared cross-section helpers.

Generated meshes live in `exports/`.

## Parameters

- `ring_outer_diameter`: outer diameter of the ring in mm.
- `cross_section_width`: wall thickness and profile width in mm.
- `cross_section_total_height`: total profile height in mm.
- `top_angle`: top-surface angle in degrees.
- `ring_angle`: angled-ring sweep in degrees.

The full ring defaults to a 150 mm outer diameter. The angled ring defaults to a
300 mm outer diameter and a 90 degree sweep.

## Print Notes

- Render and inspect the model before exporting with production parameters.
- Use print settings that produce reliable waterproof shells.
- Test buoyancy and plant containment with a small physical print before scaling
  to larger production rings.

## Quick checks

- Render all migrated source files with `tests/run-render-tests.sh`
- Override the OpenSCAD binary with `OPENSCAD=/path/to/openscad` if needed
