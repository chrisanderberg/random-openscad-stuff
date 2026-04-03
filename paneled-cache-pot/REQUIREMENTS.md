# REQUIREMENTS.md

## Hard requirements
- All dimensions shall use millimeters.
- Models shall render in stable OpenSCAD without intentional self-intersections
  or zero-thickness geometry.
- Panel variants shall align with the core cylinder.
- Source `.scad` files shall live in `models/`.

## Soft requirements
- Prefer keeping the core geometry canonical and deriving panel variants from
  it rather than forking the full pot geometry.
- Prefer sturdy, printable panel patterns over visually dense patterns that
  weaken the wall.
- Prefer keeping shared pot geometry in `lib/project/` while leaving the top
  layer in `models/`.
