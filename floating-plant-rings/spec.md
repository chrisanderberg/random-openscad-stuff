# Spec

## Goal
Design floating rings to contain floating plants in an aquarium. The rings should float on the water surface and create a barrier to keep plants contained within a specific area.

## Constraints
- **Buoyancy**: Must be buoyant enough to float with plants attached
- **Waterproof**: Designed for 3D printing with parameters that ensure waterproof prints
- **Printability**:
  - Smooth edges and surfaces
  - Printable without excessive supports
  - Avoid bridging where possible
- **Structural integrity**: Maintain adequate wall thickness for 3D printing (accounting for shell/line width)

## Design Approach: Shaped Cross-Section (`floating_plant_ring.scad`)
- **Base geometry**: Rotate-extruded polygon with triangular-rectangular cross-section
- **Buoyancy strategy**: Hollow interior (ring shape) reduces material weight
- **Key features**:
  - Cross-section consists of rectangular base with triangular top
  - Triangular top provides angled surfaces to avoid bridging during printing
  - Peak of triangle centered at middle of wall thickness
- **Parameters**:
  - `ring_outer_diameter`: Outer diameter of the ring (default: 150mm)
  - `cross_section_width`: Width of the cross-section/wall thickness (default: 8mm)
  - `cross_section_total_height`: Total height of the cross-section (default: 8mm)
  - `top_angle`: Angle of top triangular surfaces in degrees (default: 30)
  - Derived: `triangle_height = tan(top_angle) * (cross_section_width / 2)`
  - Derived: `rectangle_height = cross_section_total_height - triangle_height`

## Technical Details

### Resolution Settings
- `$fa = 1`: Minimum angle for fragments (global)
- `$fs = 1`: Minimum size for fragments (global)

### Module Structure
- `cross_section()`
- `floating_ring()`

## Outputs
- Ring (`floating_plant_ring.scad`): Shaped cross-section design
- Small ring variant: parameter variation of the same design

## Notes
- The angled top surfaces eliminate bridging concerns during printing
- The hollow ring shape reduces material weight while keeping the ring buoyant
