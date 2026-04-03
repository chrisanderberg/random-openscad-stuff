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
