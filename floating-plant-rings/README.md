# Floating Plant Rings

Printable floating rings designed to contain floating plants in an aquarium. The ring floats on the water surface and creates a barrier to keep plants contained within a specific area. The design uses a shaped cross-section that avoids bridging during printing.

## What's in this project

- **Floating ring** (`floating_plant_ring.scad`) — Rotate-extruded ring with a shaped cross-section (rectangular base + triangular top). The angled top surfaces eliminate bridging concerns during printing.
- **Angled floating ring** (`angled_floating_plant_ring.scad`) — Same cross-section, but the sweep angle is parameterized for quarter/half rings or any custom angle.

## Files

| File | Purpose |
|------|---------|
| `floating_plant_ring.scad` | Full-circle shaped cross-section design. Parameters and module (`cross_section()`, `floating_ring()`). |
| `angled_floating_plant_ring.scad` | Angled shaped cross-section design. Parameters and module (`cross_section()`, `angled_floating_ring()`). |
| `spec.md` | Project spec (goal, constraints, design approach, technical details). |
| `plan.md` | Implementation plan (milestones, approach, next steps, assumptions). |

Exported artifacts (e.g. `floating_plant_ring.stl`, `floating_plant_ring_small.stl`) are generated from the corresponding `.scad` files.

## How to use

1. **Open a ring file**:
   - Full circle: Open `floating_plant_ring.scad`. Adjust parameters at the top if needed. The `floating_ring()` module is rendered by default.
   - Angled ring: Open `angled_floating_plant_ring.scad`. Adjust parameters at the top if needed. The `angled_floating_ring()` module is rendered by default.
2. **Adjust parameters** (see Parameters section below):
   - Set the outer diameter to match your aquarium size
   - Adjust wall thickness and other dimensions as needed
3. **Export and print**:
   - Render the design in OpenSCAD (F6)
   - Export as STL or 3MF
   - Print with settings appropriate for waterproof prints (adequate shells/perimeters, appropriate infill)
4. **Testing**:
   - Test buoyancy in water before adding plants
   - Adjust parameters if needed

## Parameters (`floating_plant_ring.scad`)

- `ring_outer_diameter`: Outer diameter of the ring in mm (default: 150mm)
- `cross_section_width`: Width of the cross-section/wall thickness in mm (default: 8mm)
- `cross_section_total_height`: Total height of the cross-section in mm (default: 8mm)
- `top_angle`: Angle of top triangular surfaces in degrees (default: 30)
- `ring_angle`: Ring sweep in degrees (default: 90) in `angled_floating_plant_ring.scad`

**Derived parameters**:
- `triangle_height = tan(top_angle) * (cross_section_width / 2)`
- `rectangle_height = cross_section_total_height - triangle_height`

## Design considerations

- **Buoyancy**: The hollow ring shape reduces material weight to ensure the ring floats.
- **Printability**: The angled top surfaces eliminate bridging concerns.
- **Waterproof printing**: Ensure your printer settings produce adequate shells/perimeters.
- **Debugging**: The file includes modular structure. Comment/uncomment modules to visualize individual components.

## See also

- `spec.md` for detailed design specifications and technical details
- `plan.md` for implementation notes and future work
