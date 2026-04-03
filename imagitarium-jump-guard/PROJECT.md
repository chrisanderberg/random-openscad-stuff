# PROJECT.md

## Overview
This project models a 3D-printable rear gap guard for a shallow Imagitarium
tank. The part clips onto the back glass and extends inward under the lid area
to block the opening so a fish cannot jump out.

The project is intentionally small. The codebase should stay easy to scan, and
the documentation should stay focused on physical requirements, fit assumptions,
and reusable modeling guidance.

## Current goals
- Keep the design printable and easy to tune for real-world fit.
- Preserve a reusable profile module in `lib/project/` while keeping
  `models/gap_guard.scad` as the top-level printable variant.
- Keep generated artifacts in `exports/` rather than mixing them with source
  files.
- Keep validation lightweight through a render matrix and optional CLI script.

## Physical context
- The part clips onto the rimless back glass.
- It is not intended to support the lid.
- The key job is blocking the rear opening over some chosen length while
  clearing the lid.
- Different print lengths may be useful to leave space for cords or tubing.

## Modeling notes
- The guard is built from a reusable 2D profile in the X-Y plane and extruded
  along Z.
- Origin convention for the profile:
  - `(0, 0)` is the top edge of the tank glass at the inner back corner.
  - `+X` points into the tank.
  - `-Y` points downward from the rim.

## Tooling notes
- `tests/run-render-tests.sh` runs the current render matrix through the
  OpenSCAD CLI.
- `openscad-cli.md` contains macOS-specific CLI notes for headless exports.

## Scope guidance
- Keep this file focused on context, intent, and notes that do not belong in
  `REQUIREMENTS.md`.
- Put binding constraints and preferred defaults in `REQUIREMENTS.md`.
