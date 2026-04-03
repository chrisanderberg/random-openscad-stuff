# PROJECT.md

## Overview
This project models a 3D-printable guard for the feeder or access hole in a
clear Imagitarium lid. The part covers the opening from above and uses an
underside locating lip so it can sit securely in place without falling through.

## Current goals
- Keep the project small and easy to scan.
- Preserve `models/lid_hole_jump_guard.scad` as the top-level printable
  variant.
- Keep reusable geometry in `lib/project/`.
- Keep generated artifacts and reference images under `exports/`.

## Physical context
- The target opening is a rounded rectangle inside a larger lid feature.
- The guard should be easy to remove for feeding and maintenance.
- The part should not interfere with normal lid use, water level, or nearby
  floating plants more than necessary.

## Measurement notes
- The current model uses measured defaults near `50 mm` wide by `35 mm` tall.
- Reference photos used during the first modeling pass are stored in
  `exports/references/`.
- Corner radii and available underside depth should be confirmed on the
  physical lid before exporting a final production mesh.

## Modeling notes
- The part uses a top flange larger than the opening and an underside lip
  smaller than the opening.
- Rounded-rectangle helpers live in `lib/project/lid_hole_guard.scad`.
- The top-level model keeps fit-sensitive parameters near the top of the file.

## Scope guidance
- Keep this file focused on context, measurement notes, and design intent.
- Put binding implementation constraints in `REQUIREMENTS.md`.
