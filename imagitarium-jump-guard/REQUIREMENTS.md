# REQUIREMENTS.md

## Purpose
This file is the implementation contract for the jump-guard design. Hard
requirements are binding; soft requirements are the preferred defaults for how
to model and evolve the part.

## How to interpret this file
- Hard requirements are mandatory unless explicitly changed by the human.
- Soft requirements are preferred guidance and may be refined when better
  reusable patterns are discovered.
- Keep this file concise and focused on durable constraints or guidance.

## Hard requirements
- All dimensions shall use millimeters.
- The part shall render in stable OpenSCAD without intentional
  self-intersections or zero-thickness geometry.
- The part shall clip onto `4.0 mm` rimless back glass, with fit tuning exposed
  through `clip_clearance`.
- The lid bottom reference shall assume:
  - `lid_t = 3.0`
  - `lid_top_below_rim = 1.0`
- The default design shall block the rear opening without supporting the lid.
- The default design shall remain support-free in the intended print
  orientation.
- `models/` shall contain source `.scad` files only, not generated meshes.
- Generated meshes and test exports shall be written under `exports/`.
- The public parameter block in `models/gap_guard.scad` shall remain the main
  tuning surface for printable variants.

## Soft requirements
- Prefer a reusable 2D profile plus `linear_extrude()` over more complex 3D
  constructions for this part.
- Prefer `models/gap_guard.scad` to stay a thin wrapper over
  `lib/project/gap_guard.scad`.
- Prefer fit-sensitive values such as clearances, wall thicknesses, and gap
  depth to stay explicit and documented near the public parameter block.
- Prefer lightweight debug geometry behind `debug = false`.
- Prefer chamfers or simple relief features over expensive operations such as
  `minkowski()`.
- Prefer render validation through `tests/render-matrix.md` and
  `tests/run-render-tests.sh` rather than a heavier testing framework.
- Prefer recording unresolved printer-tuning questions in `Open questions`
  rather than hardcoding one printer's behavior as universal.

## Candidate promotions to hard requirements
- None yet.

## Open questions
- The best default `clip_clearance` may vary by printer and PETG tuning.
- Final preferred guard length may depend on cable and airline routing around
  the tank.
