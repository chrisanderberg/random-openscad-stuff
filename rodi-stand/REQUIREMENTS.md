# REQUIREMENTS.md

## Hard requirements
- All dimensions shall use millimeters.
- Models shall render in stable OpenSCAD without intentional self-intersections
  or zero-thickness geometry.
- The stand shall fit within the intended 256 x 256 x 256 mm build volume, with
  mount plates allowed to extend effective height as separate printed parts.
- Mounting alignment values shared across stand, ring, and plates shall remain
  consistent.
- Shared geometry used by multiple entrypoints shall live under `lib/project/`.
- Generated meshes shall live in `exports/`.

## Soft requirements
- Prefer keeping stand, ring, and plate entrypoints separate while centralizing
  shared geometry that truly repeats.
- Prefer support-aware, print-oriented geometry over decorative complexity.
- Prefer keeping mechanical alignment parameters obvious near the top of the
  main entrypoint files.

## Open questions
- If this project becomes active again, mount plate and stand shared parameters
  may deserve an additional helper include or central parameter module.
