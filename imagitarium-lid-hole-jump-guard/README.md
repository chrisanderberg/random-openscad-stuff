# Lid Hole Jump Guard

A 3D-printable guard for the feeder or access hole in a clear Imagitarium lid. The
part sits on top of the lid opening, locates with an underside lip, and helps
prevent a fish from jumping through the opening while still allowing the part
to be removed for feeding or maintenance.

## Project layout

- `PROJECT.md` for context, measurements, and design notes
- `REQUIREMENTS.md` for hard and soft requirements
- `AGENTS.md` for minimal agent instructions
- `lib/project/` for reusable geometry helpers
- `models/` for top-level printable variants
- `tests/` for the render matrix and lightweight CLI checks
- `exports/` for generated artifacts and reference images

## Quick start

1. Open `models/lid_hole_jump_guard.scad` in OpenSCAD.
2. Adjust the measured opening parameters near the top of the file as needed.
3. Render and export to `exports/`.

## Validation

- Review `tests/render-matrix.md` for the current fit-sensitive cases.
- Run `tests/run-render-tests.sh` for a quick CLI render check.

## References

- `PROJECT.md` for opening measurements and physical context
- `REQUIREMENTS.md` for the current implementation contract
- `exports/references/` for the reference photos used during initial modeling
