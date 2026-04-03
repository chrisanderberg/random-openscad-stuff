# Render / Validation Matrix

Use this as a lightweight test plan. Add cases as the project evolves.

## General checks (every model)
- [ ] Renders without errors in OpenSCAD stable.
- [ ] No obviously zero-thickness walls.
- [ ] No unintended self-intersections.
- [ ] Parameter defaults render a sensible part.
- [ ] Debug mode (if present) doesn't change the exported solid.

## Gap guard render cases

How to run: edit the relevant parameter(s) in `models/gap_guard.scad` and render (OpenSCAD GUI or CLI). Debug mode should not change the exported solid (see General checks). No automation required unless added later.

| Case | Parameters to set | Expected |
|------|-------------------|----------|
| **Default** | Use current defaults in `models/gap_guard.scad` | Clean render, correct size, clip + tongue visible. |
| **clip_clearance** | `clip_clearance` = 0.2, 0.4, 0.6 (three runs) | Channel width changes; clip still fits 4 mm glass; no zero-thickness walls. |
| **wall_t** | `wall_t` = 1.2, 1.6, 2.4 (three runs) | Part scales; min 1.2 mm wall thickness maintained (per project spec); no collapsed features. |
| **gap_depth** | `gap_depth` = 25, 29, 33 with `tongue_margin` fixed at 2.0 (three runs) | Tongue depth changes; gap coverage adjusts; no invalid geometry. |

Artifact rule:
- Write generated meshes for these cases to `exports/`, not `models/`.
