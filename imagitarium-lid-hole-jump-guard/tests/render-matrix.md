# Render / Validation Matrix

Use this as a lightweight test plan. Add cases as the project evolves.

## General checks (every model)
- [ ] Renders without errors in OpenSCAD stable.
- [ ] No obviously zero-thickness walls.
- [ ] No unintended self-intersections.
- [ ] Parameter defaults render a sensible part.
- [ ] Debug mode (if present) doesn't change the exported solid.
- [ ] Generated meshes are written to `exports/`, not committed next to source
  models.

## Suggested parameter cases
1. Default parameters
   - Expected: clean render, correct overall size, key features present.

2. Minimum-ish values (edge case)
   - Reduce wall thickness to minimum allowed by spec.
   - Expected: still printable, no features collapse.

3. Maximum-ish values (stress case)
   - Increase overall dimensions.
   - Expected: performance still acceptable, no artifacts.

4. Clearance/tolerance sweep (if relevant)
   - clearance = 0.2 / 0.3 / 0.4
   - Expected: mating features adjust as intended.

## Lid guard cases
1. Default lid guard
   - Model: `models/lid_hole_jump_guard.scad`
   - Expected: flange fully overlaps opening, underside lip remains inside the
     nominal opening, pull tab is intact, vent slots cut only through the top.

2. Fit sweep
   - Parameters: `fit_clearance = 0.2 / 0.35 / 0.5`
   - Expected: lip shrinks without collapsing wall thickness or corner radii.

3. Shallow lid sweep
   - Parameters: `lip_depth = 3 / 4.5 / 6`
   - Expected: model remains manifold and printable for lids with limited
     underside depth.

4. Feed hole sweep
   - Parameters: `feed_hole_funnel_angle_deg = 0 / 30 / 45`, `feed_hole_offset_y = -8 / 0 / 8`
   - Expected: bottom opening stays constant, top opening widens as angle
     increases, and offset stays on the long-side axis without breaking out of
     the flange.

5. Funnel extension sweep
   - Parameters: `feed_hole_funnel_extension_depth = 0 / 3 / 6`
   - Expected: a conical wall can extend into the lip cavity while the exit
     opening stays constant and the overall solid remains manifold.
