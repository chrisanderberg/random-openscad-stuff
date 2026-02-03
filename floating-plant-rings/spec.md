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

## Design Approaches

### Variant 1: Cylindrical Cutouts (`floating_plant_ring.scad`)
- **Base geometry**: Outer cylinder with inner cylinder subtracted to create the ring
- **Buoyancy strategy**: Internal cylindrical cutouts distributed around the ring circumference
- **Key features**:
  - Inner cylinder is 1mm taller than outer cylinder to avoid coplanar face artifacts
  - Cylindrical cutouts are internal geometry (shorter than ring height) to reduce weight
  - Cutout diameter accounts for shell thickness: `thickness - 4 * line_width` (2 shells per side)
  - Cutouts positioned at middle of wall thickness, evenly distributed around circumference
- **Parameters**:
  - `outer_diameter`: Outer diameter of the ring (default: 200mm)
  - `thickness`: Wall thickness (default: 7.5mm)
  - `spherical_cutout_count`: Number of cylindrical cutouts (default: 72)
  - `line_width`: 3D printer line width for shell calculations (default: 0.82mm)

### Variant 2: Shaped Cross-Section (`floating_plant_ring_2.scad`)
- **Base geometry**: Rotate-extruded polygon with triangular-rectangular cross-section
- **Buoyancy strategy**: Hollow interior (ring shape) reduces material weight
- **Key features**:
  - Cross-section consists of rectangular base with triangular top
  - Triangular top provides angled surfaces to avoid bridging during printing
  - Peak of triangle centered at middle of wall thickness
  - No internal cutouts needed - shape itself provides buoyancy
- **Parameters**:
  - `ring_outer_diameter`: Outer diameter of the ring (default: 150mm)
  - `cross_section_width`: Width of the cross-section/wall thickness (default: 8mm)
  - `cross_section_total_height`: Total height of the cross-section (default: 8mm)
  - `top_angle`: Angle of top triangular surfaces in degrees (default: 30°)
  - Derived: `triangle_height = tan(top_angle) * (cross_section_width / 2)`
  - Derived: `rectangle_height = cross_section_total_height - triangle_height`

## Technical Details

### Resolution Settings
- `$fa = 1`: Minimum angle for fragments (global)
- `$fs = 1`: Minimum size for fragments (global)

### Module Structure
Both variants use modular design:
- **Variant 1**: `ring()`, `spherical_cutouts()`, `complete_ring()`
- **Variant 2**: `cross_section()`, `floating_ring()`

Modules can be commented/uncommented for debugging and visualization.

## Outputs
- Ring variant 1 (`floating_plant_ring.scad`): Cylindrical cutout design
- Ring variant 2 (`floating_plant_ring_2.scad`): Shaped cross-section design
- Small ring variant: TBD (may be parameter variation of existing designs)

## Notes
- `floating_plant_ring.scad` and `floating_plant_ring_2.scad` are separate design approaches to compare effectiveness
- Both designs aim to reduce weight while maintaining structural integrity
- Variant 2's angled top surfaces eliminate bridging concerns during printing
- Variant 1 requires careful consideration of shell thickness for waterproof printing
