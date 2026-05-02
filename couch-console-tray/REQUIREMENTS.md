# REQUIREMENTS.md

## Purpose
This file is the current implementation contract for the couch console tray.

## Hard requirements
- All dimensions shall be expressed in millimeters.
- Models shall render in stable OpenSCAD without intentional self-intersections
  or zero-thickness geometry.
- `models/` shall contain top-level renderable `.scad` files, not generated
  meshes.
- Generated meshes and renders shall live under `exports/` or another ignored
  artifact directory, not alongside source models.
- Public parameters for a printable variant shall be declared near the top of
  the corresponding file.
- Shared project dimensions shall live in one reusable parameter file so fit
  test models and final models stay synchronized.
- The tray shall include two downward locating features sized to sit in the cup
  holders.
- The tray shall include an underside support lip around the perimeter, with
  two back-side gaps for the console side walls.
- The tray shall include a thin rear section that extends into the storage area
  so the lid can rest on top of it.
- Estimated measurements derived from photos shall be clearly marked as
  estimates until verified.

## Soft requirements
- Prefer `models/` to stay thin and move reusable geometry into
  `lib/project/`.
- Prefer simple CSG and 2D profile plus `linear_extrude()` approaches for the
  tray body and support lip.
- Prefer frustum-style cup holder plugs over perfectly cylindrical plugs to
  make first-print fit tuning easier.
- Prefer conservative clearances on the first prototype so the part is more
  likely to fit without sanding.
- Prefer dedicated low-material fit-test models for local dimension checks
  before printing the full tray.
- Prefer recording unresolved fit assumptions under `Open questions`.

## Open questions
- Exact maximum thickness the lid will tolerate at the rear support edge.
- Whether the perimeter support lip should bear on upholstery, a rigid plastic
  rim, or both.
