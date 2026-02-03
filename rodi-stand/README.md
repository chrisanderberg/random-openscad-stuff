# RO/DI Stand

A printable portable stand and mounting system for an RO/DI water filter unit. The unit is normally wall-mounted; this project provides a wide base with a flat vertical mounting surface (like a wall) so the unit can be used portably and stay balanced over the base.

## What’s in this project

- **Stand** — Base (chamfered polygon with honeycomb cutout in the front) plus a vertical gluing surface and two gussets. The top of the mounting structure can be cut at an angle. Designed to fit a 256×256×256 mm build plate.
- **Mount ring** — Ring that clamps or mounts the RO/DI unit (inner/outer diameter, wedge opening, screw cutouts). Shares screw spacing with the stand and plates.
- **Mount plates** — Extra vertical plates that extend the mounting height beyond what fits in one print. Same width as the stand’s gluing surface; printed on their side (and optionally diagonally) and glued to the stand.

## Files

| File | Purpose |
|------|---------|
| `stand.scad` | Stand (base + mounting structure). Main parameters and `stand()` module. Can also render mount ring and mount plate for export. |
| `mount_ring.scad` | Mount ring entrypoint; uses shared ring logic. |
| `mount_plates.scad` | Mount plate entrypoint; defines plate length and screw layout. |
| `mount_ring_module.scad` | Mount ring geometry (used by `stand.scad` and/or `mount_ring.scad`). |
| `spec.md` | Project spec (goal, constraints, outputs). |
| `plan.md` | Plan (approach, milestones, next steps). |

Exported artifacts (e.g. `stand.stl`, `mount_ring.stl`, `mount_plate.stl`, `base.stl`, `test_mount_plate.stl`) are generated from the corresponding `.scad` files.

## How to use

1. Open the file for the part you want:
   - **Stand**: `stand.scad` — ensure `stand()` is uncommented at the bottom (and comment out other renders if needed), then export STL/3MF.
   - **Mount ring**: `mount_ring.scad` — export STL/3MF.
   - **Mount plate**: `mount_plates.scad` — set plate length and screw positions as needed, then export STL/3MF (print on side; long plates can be arranged diagonally on the build plate).
2. Print the stand in one piece. Print the mount ring and mount plates separately.
3. Glue the mount plates to the stand’s gluing surface to extend height. Attach the mount ring and RO/DI unit as intended.

## Parameters

Key dimensions (e.g. base size, mounting surface width and height, gluing surface vs mount plate thickness, honeycomb, gussets, screw spacing, top angle) are defined at the top of `stand.scad`. Mount ring and mount plate files may define or override their own parameters; keep `mount_width` and `screw_spacing` aligned so parts fit together.

See `spec.md` for the full list of outputs and parameters; see `plan.md` for implementation notes and milestones.
