# Plan

## Milestones

- **Shaped cross-section ring**: Rotate-extruded polygon with triangular-rectangular cross-section to eliminate bridging concerns.
- **Modular structure**: Organized into reusable modules for easy testing and debugging.
- **Parameter refinement**: Cross-section geometry tuned for printability and buoyancy.

## Approach (steps taken)

1. **Cross-section design**: Created polygon-based cross-section with rectangular base and triangular top. Triangle peak centered at middle of wall thickness.
2. **Rotate extrude**: Used `rotate_extrude()` to create ring from 2D cross-section profile.
3. **Parameter simplification**: Refactored from individual `rectangle_height` and `triangle_height` to `cross_section_total_height` and `top_angle` for more intuitive control.
4. **Angle calculation**: Derived triangle height from angle: `triangle_height = tan(top_angle) * (cross_section_width / 2)`. Rectangle height calculated as remainder: `rectangle_height = cross_section_total_height - triangle_height`.
5. **Bridging avoidance**: Triangular top provides angled surfaces (default 30) to eliminate bridging during printing.

## Next Steps

- Print test rings at target sizes to validate buoyancy and print quality.
- Validate wall thickness and shell settings produce waterproof prints.
- Consider small ring variant if needed for different plant sizes or tank configurations.
- Fine-tune parameters based on print results and floating behavior.

## Open Questions

- Are the current wall thickness and cross-section dimensions sufficient for waterproof printing?
- What is the optimal `top_angle` to balance printability and material usage?

## Assumptions

- Triangular top angle of 30 provides good balance between avoiding bridging and material efficiency.
