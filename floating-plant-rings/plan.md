# Plan

## Milestones

- **Variant 1 (Cylindrical cutouts)**: Basic ring geometry with internal cylindrical cutouts for buoyancy; wall thickness calculations accounting for 3D printing shells.
- **Variant 2 (Shaped cross-section)**: Alternative design using rotate-extruded polygon with triangular-rectangular cross-section to eliminate bridging concerns.
- **Modular structure**: Both variants organized into reusable modules for easy testing and debugging.
- **Parameter refinement**: Wall thickness, cutout sizing, and cross-section geometry tuned for printability and buoyancy.

## Approach (steps taken)

### Variant 1: `floating_plant_ring.scad`

1. **Basic ring geometry**: Created outer cylinder with inner cylinder subtracted to form ring. Inner cylinder made 1mm taller than outer to avoid coplanar face artifacts.
2. **Initial buoyancy attempt**: Added spherical cutouts distributed around ring circumference, positioned at middle of wall thickness.
3. **Cylindrical cutouts**: Changed from spheres to vertical cylinders for better internal geometry control. Cylinders sized at 80% of wall thickness initially.
4. **Shell-aware sizing**: Refined cylinder diameter calculation to account for 3D printing shells: `cylinder_diameter = thickness - 4 * line_width` (2 shells per side). Ensures adequate wall thickness between cutouts and ring surfaces.
5. **Internal geometry**: Made cutouts shorter than ring height (`cylinder_height = height * 0.8`) so they remain internal cavities rather than extending through the ring.
6. **Modular structure**: Organized into `ring()`, `spherical_cutouts()`, and `complete_ring()` modules for easy testing and visualization.

### Variant 2: `floating_plant_ring_2.scad`

1. **Cross-section design**: Created polygon-based cross-section with rectangular base and triangular top. Triangle peak centered at middle of wall thickness.
2. **Rotate extrude**: Used `rotate_extrude()` to create ring from 2D cross-section profile.
3. **Parameter simplification**: Refactored from individual `rectangle_height` and `triangle_height` to `cross_section_total_height` and `top_angle` for more intuitive control.
4. **Angle calculation**: Derived triangle height from angle: `triangle_height = tan(top_angle) * (cross_section_width / 2)`. Rectangle height calculated as remainder: `rectangle_height = cross_section_total_height - triangle_height`.
5. **Bridging avoidance**: Triangular top provides angled surfaces (default 30°) to eliminate bridging during printing.

### Common refinements

- **Resolution settings**: Applied `$fa = 1` and `$fs = 1` globally for consistent smooth surfaces.
- **Debugging support**: Modules can be commented/uncommented for visualization and testing.

## Next Steps

- Print test rings at target sizes to validate buoyancy and print quality.
- Compare effectiveness of Variant 1 (cutouts) vs Variant 2 (shaped cross-section) in actual use.
- Validate wall thickness and shell calculations produce waterproof prints.
- Consider small ring variant if needed for different plant sizes or tank configurations.
- Fine-tune parameters based on print results and floating behavior.

## Open Questions

- Which variant provides better buoyancy-to-weight ratio?
- Are the current wall thickness calculations sufficient for waterproof printing?
- What is the optimal `top_angle` for Variant 2 to balance printability and material usage?
- Should cutout count (Variant 1) be adjusted based on ring diameter?

## Assumptions

- `line_width = 0.82mm` represents typical 3D printer line width for shell calculations.
- Two shell layers per side (4× line_width total) provides adequate wall strength.
- Inner cylinder height offset of 1mm is sufficient to avoid coplanar face artifacts.
- Triangular top angle of 30° (Variant 2) provides good balance between avoiding bridging and material efficiency.
- Cylindrical cutouts positioned at middle of wall thickness provide optimal weight distribution.
