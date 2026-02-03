# Floating Plant Rings

Printable floating rings designed to contain floating plants in an aquarium. The rings float on the water surface and create a barrier to keep plants contained within a specific area. Two design variants are provided to compare different approaches to achieving buoyancy and printability.

## What's in this project

- **Variant 1** (`floating_plant_ring.scad`) — Cylindrical ring with internal cylindrical cutouts for buoyancy. Uses traditional CSG operations (difference of cylinders) with strategically placed internal cavities to reduce weight.
- **Variant 2** (`floating_plant_ring_2.scad`) — Rotate-extruded ring with a shaped cross-section (rectangular base + triangular top). The angled top surfaces eliminate bridging concerns during printing.

## Files

| File | Purpose |
|------|---------|
| `floating_plant_ring.scad` | Variant 1: Cylindrical cutout design. Main parameters and modules (`ring()`, `spherical_cutouts()`, `complete_ring()`). |
| `floating_plant_ring_2.scad` | Variant 2: Shaped cross-section design. Parameters and modules (`cross_section()`, `floating_ring()`). |
| `spec.md` | Project spec (goal, constraints, design approaches, technical details). |
| `plan.md` | Implementation plan (milestones, approach, next steps, assumptions). |

Exported artifacts (e.g. `floating_plant_ring.stl`, `floating_plant_ring_2.stl`, `floating_plant_ring_small.stl`) are generated from the corresponding `.scad` files.

## How to use

1. **Choose a variant**:
   - **Variant 1**: Open `floating_plant_ring.scad`. Adjust parameters at the top if needed. Ensure `complete_ring()` is uncommented at the bottom (comment out `ring()` and `spherical_cutouts()` for final export).
   - **Variant 2**: Open `floating_plant_ring_2.scad`. Adjust parameters at the top if needed. The `floating_ring()` module is rendered by default.

2. **Adjust parameters** (see Parameters section below):
   - Set the outer diameter to match your aquarium size
   - Adjust wall thickness and other dimensions as needed
   - For Variant 1, adjust `line_width` to match your printer's settings

3. **Export and print**:
   - Render the design in OpenSCAD (F6)
   - Export as STL or 3MF
   - Print with settings appropriate for waterproof prints (adequate shells/perimeters, appropriate infill)

4. **Testing**:
   - Test buoyancy in water before adding plants
   - Both variants should float; adjust parameters if needed

## Parameters

### Variant 1 (`floating_plant_ring.scad`)

- `outer_diameter`: Outer diameter of the ring in mm (default: 200mm)
- `thickness`: Wall thickness in mm (default: 7.5mm)
- `spherical_cutout_count`: Number of cylindrical cutouts around the ring (default: 72)
- `line_width`: 3D printer line width in mm for shell calculations (default: 0.82mm)

**Derived parameters**:
- `inner_diameter = outer_diameter - (2 * thickness)`
- `cylinder_diameter = thickness - 4 * line_width` (ensures adequate wall thickness)
- `cylinder_height = height * 0.8` (keeps cutouts internal)

### Variant 2 (`floating_plant_ring_2.scad`)

- `ring_outer_diameter`: Outer diameter of the ring in mm (default: 150mm)
- `cross_section_width`: Width of the cross-section/wall thickness in mm (default: 8mm)
- `cross_section_total_height`: Total height of the cross-section in mm (default: 8mm)
- `top_angle`: Angle of top triangular surfaces in degrees (default: 30°)

**Derived parameters**:
- `triangle_height = tan(top_angle) * (cross_section_width / 2)`
- `rectangle_height = cross_section_total_height - triangle_height`

## Design considerations

- **Buoyancy**: Both variants reduce material weight to ensure the rings float. Variant 1 uses internal cutouts; Variant 2 relies on the hollow ring shape.
- **Printability**: Variant 2's angled top surfaces eliminate bridging concerns. Variant 1 requires careful consideration of wall thickness for waterproof printing.
- **Waterproof printing**: For Variant 1, ensure your printer settings produce adequate shells/perimeters. The `line_width` parameter helps calculate appropriate cutout sizes.
- **Debugging**: Both files include modular structure. Comment/uncomment modules to visualize individual components (e.g., just the ring without cutouts, or just the cutouts).

## See also

- `spec.md` for detailed design specifications and technical details
- `plan.md` for implementation notes and future work
