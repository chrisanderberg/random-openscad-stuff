# REQUIREMENTS.md

## Hard requirements
- All dimensions shall be expressed in millimeters.
- Models shall render in stable OpenSCAD without intentional self-intersections
  or zero-thickness geometry.
- `models/` shall contain top-level renderable `.scad` files, not generated
  meshes.
- Generated meshes and renders shall live under `exports/` or another ignored
  artifact directory, not alongside source models.
- Public fit-critical parameters shall be declared near the top of each model
  file.
- The project shall provide a simple cylindrical plug variant.
- The project shall provide a stepped plug variant with a narrower insert and a
  wider head.

## Soft requirements
- Prefer a centered Z-axis cylinder model for straightforward print orientation.
- Prefer dimension names that match the physical pencil and cap features.
- Prefer recording uncertain measured defaults as assumptions instead of
  implying they are exact.

## Open questions
- The ideal plug length should be tuned against the actual click travel so the
  cap clears the pencil body during actuation.
