# REQUIREMENTS.md

## Purpose
This file is the current implementation contract for the project. Use hard
requirements for binding constraints and soft requirements for preferred
defaults that may evolve over time.

## How to interpret this file
- Hard requirements are mandatory unless the human explicitly changes them.
- Soft requirements are the default way to work, but they may be refined when a
  better reusable pattern is discovered.
- Keep this file concise. Record only durable constraints or reusable guidance.

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

## Soft requirements
- Prefer `PROJECT.md` for project context and `REQUIREMENTS.md` for the actual
  implementation contract rather than maintaining a large stack of spec files.
- Prefer `models/` to stay thin and move reusable geometry into
  `lib/project/`.
- Prefer simple CSG and 2D profile plus `linear_extrude()` approaches for
  prismatic parts unless the shape needs something more complex.
- Prefer explicit parameter names and comments for physical measurements and
  fit-related values.
- Prefer `debug = false` as the default for optional visualization helpers.
- Prefer recording unresolved fit questions or measurement uncertainty under
  `Open questions` instead of silently baking assumptions into code.
- Prefer a lightweight render matrix in `tests/` for important parameter sweeps
  or fit-sensitive cases.

## Candidate promotions to hard requirements
- None yet.

## Open questions
- None yet.
