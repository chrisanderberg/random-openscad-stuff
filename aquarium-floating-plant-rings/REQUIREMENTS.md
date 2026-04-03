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
