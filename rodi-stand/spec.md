# Spec

## Goal
Design a printable portable stand and mounting system for an RO/DI water filter unit. The unit is normally wall-mounted; this stand provides a flat mounting surface (like a wall) on a wide base so the unit can be used portably and remain balanced over the base.

## Constraints
- **Build volume**: Fits a 256×256×256 mm build plate. Mount plates may be printed on their side and arranged diagonally to achieve lengths >256 mm (e.g. 325 mm).
- **Mounting alignment**: Mounting surface width and screw spacing are shared so stand, mount ring, and mount plates align. Stand gluing surface thickness and mount plate thickness may differ (gluing surface on base is thinner; mount plate is a separate part that glues to it).
- **Units**: Millimeters. Z up.
- **OpenSCAD**: Most recent stable release; prefer simple CSG, linear_extrude for prismatic parts; avoid polyhedron/minkowski unless needed.

## Outputs
- **Stand** (`stand.scad` → `stand()`): Base + mounting structure. Base is an extruded polygon (chamfered corners), with a honeycomb cutout in the front portion only; back portion is solid for the mounting structure. Mounting structure: gluing surface (flat wall-like surface on base) + two gussets (cubes) each side; optional angled cut across the top (single rotated-cube cut in `angled_top_cut()`). One translation in `stand()` places the mounting stand on the base.
- **Mount ring** (`mount_ring.scad` / `lib/mount_ring_lib.scad`): Ring that mounts the RO/DI unit (inner/outer diameter, wedge opening, screw cutouts). Shares `screw_spacing` with stand/plates.
- **Mount plates** (`mount_plates.scad` / `lib/mount_plate_lib.scad`): Plates that extend the effective height of the mounting surface beyond the printable stand height. Same width as stand mounting surface; printed on their side (layers vertical in final assembly) and can be arranged diagonally. Glued to the stand gluing surface. Include screw/insert holes for attachment. May include a test plate variant (e.g. `test_mount_plate()`).

## Key parameters (defined in stand.scad; mount ring/plate files may use or override)
- Base: `base_width`, `base_depth`, `base_thickness`, corner cuts (`base_front_corner_cut`, `base_back_corner_cut`).
- Mounting surface: `mount_width` (e.g. 100 mm / ~4 in), `mount_height`, `base_glueing_surface_thickness` (thickness of surface on base), `mount_thickness` (thickness of mount plate part).
- Stand position: `stand_offset_from_back`, `stand_position_x` (e.g. center of base).
- Honeycomb: `honeycomb_*` (radius, margins, back margin so back stays solid).
- Gussets: `gusset_depth`, `gusset_thickness`; top surface: `top_surface_angle` (degrees).
- Screws: `screw_spacing` (shared); ring uses `screw_hole_diameter`, `screw_access_diameter`, etc.; plates use `plate_insert_*` and hole spacing.

## Notes
- Primary entrypoints: `stand.scad` (stand, mount_ring, mount_plate modules / render), `mount_ring.scad`, `mount_plates.scad`. Shared logic may live in `lib/` (e.g. `mount_ring_lib.scad`, `mount_plate_lib.scad`).
- Angled top cut is in its own module `angled_top_cut()` for easier debugging.
