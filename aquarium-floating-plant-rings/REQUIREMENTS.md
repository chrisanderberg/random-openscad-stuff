# REQUIREMENTS.md

## Hard requirements
- All dimensions shall use millimeters.
- Models shall render in stable OpenSCAD without intentional self-intersections
  or zero-thickness geometry.
- The ring geometry shall remain buoyant-oriented and printable without
  excessive bridging in the default design.
- Source `.scad` files shall live in `models/`.
- Generated meshes shall live in `exports/`.

## Soft requirements
- Prefer the shaped cross-section approach over flat-topped geometry when it
  materially improves printability.
- Prefer keeping the full ring and angled ring behavior aligned through shared
  parameters and helper modules in `lib/project/`.
- Prefer documenting waterproof-print assumptions and wall-thickness tradeoffs
  near the parameter blocks.
- Prefer the angled ring implementation to preserve the cleaned CSG structure:
  raw union first, then radial cleanup volumes, then outer-arc cleanup passes.
- Prefer exposing `ring_outer_diameter`, `cross_section_width`,
  `cross_section_total_height`, `top_angle`, and `ring_angle` as the main
  tuning surface for the ring family.

## Open validation questions
- Are the current wall thickness and cross-section dimensions sufficient for
  reliably waterproof prints on the target printer setup?
- What `top_angle` gives the best tradeoff between support-free printing,
  buoyancy, and material use?
- Does the angled ring need small epsilon offsets in its cleanup volumes to
  avoid preview or export artifacts at some sweep angles?
