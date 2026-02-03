# Plan

## Approach
- **Stand**: Single file `stand.scad` with parameters at top. Base = extruded polygon with honeycomb difference (front only). Mounting stand = union of gluing surface cube + two gusset cubes, minus `angled_top_cut()` (rotated cube). One `translate([stand_x, stand_y, base_thickness])` in `stand()` positions the mounting stand.
- **Mount ring**: Implemented in `lib/mount_ring_lib.scad`; `mount_ring.scad` is a thin wrapper with parameters and `mount_ring()` call.
- **Mount plates**: Implemented in `lib/mount_plate_lib.scad`; `mount_plates.scad` is a thin wrapper. Plates are cubes with screw/insert holes; print orientation is on side (rotate 90° around X) and optionally diagonal (45° around Z) for long plates.
- **Shared variables**: `screw_spacing`, `mount_width`, and (where applicable) `mount_thickness` / `base_glueing_surface_thickness` are defined in stand and used or overridden in ring/plate files so dimensions stay aligned.

## Milestones
- [x] Stand footprint and base (extruded polygon, honeycomb front only).
- [x] Mounting surface and gussets (cubes, union, single translation in `stand()`).
- [x] Angled top cut (separate module `angled_top_cut()`, rotated cube then translate Z).
- [x] Mount ring fit and screw clearance (lib + wrapper).
- [x] Mount plate extensions, print orientation, and screw/insert holes (lib + wrapper).
- [ ] Validate printed stand + plates + ring together (fit, balance, screw alignment).

## Next steps
- Re-enable or adjust `angled_top_cut()` in `stand.scad` if it was disabled for debug; tune `top_surface_angle` and cut cube size/position as needed.
- Confirm `base_glueing_surface_thickness` vs `mount_thickness` and glue joint in real use.
- Document in plan or spec which render to use for each export (stand, ring, plate, test plate).

## Open questions
- Final value for `top_surface_angle` and whether angled top is desired in production.
- Whether mount ring parameters in `stand.scad` are canonical or overridden by `mount_ring.scad` / lib.

## Assumptions
- RO/DI unit mounts to a flat vertical surface; 4 in (~100 mm) width is sufficient.
- Stand is printed in one piece; plates and ring are separate prints. Plates are glued to the stand gluing surface.
- Honeycomb is for weight/material reduction; back of base remains solid for strength at the mounting structure.
- Coordinate system: Z up; origin of mounting stand geometry is at back edge, center X, bottom Z, then translated by `stand()` to final position on base.
