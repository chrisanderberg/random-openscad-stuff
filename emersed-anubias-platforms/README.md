# Emersed Anubias Platforms

Printable platforms for growing anubias emersed (leaves above water, roots in nutrient-rich water). The platform sits on a container; a honeycomb grid lets roots pass through into the water while the rim and legs provide stable support on the container edges.

## What's in this project

- **Rectangle variant** (`emersed_anubias_platform_rectangle.scad`) — Rectangular platform (width × length × thickness). Shape is a hull of four corner cylinders; rim and inner hole are hulls of cylinders. Legs at corners and evenly along all four edges.
- **Polygon variant** (`emersed_anubias_platform_polygon.scad`) — Platform defined by `platform_points` (arbitrary polygon) for odd-shaped containers. Rim uses polygon offset; legs on vertices and along each edge. Optional middle legs with large hexagon holes and 6-triangle support for large or uneven-bottom containers.
- **Container-specific variants** — Glad and Rubbermaid wrappers with fixed dimensions and optional middle legs; export STL/3MF per variant.

## Files

| File | Purpose |
|------|---------|
| `emersed_anubias_platform_rectangle.scad` | Rectangle platform. Parameters: platform dimensions, rim_width, leg_length, leg_max_spacing, honeycomb (hex_radius, hex_spacing_factor). |
| `emersed_anubias_platform_polygon.scad` | Polygon platform. Parameters: platform_points, rim_width, leg_length, leg_max_spacing, hexagon_width, hexagon_edge_separation, middle_leg_positions, middle_leg_lengths. Uses `lib/platform_polygon_lib.scad`. |
| `emersed_anubias_platform_glad_container.scad` | Glad container–sized platform (parameters or wrapper). |
| `emersed_anubias_platform_rubbermaid_container.scad` | Rubbermaid container–sized platform (parameters or wrapper). |
| `lib/platform_polygon_lib.scad` | Shared polygon platform logic (rim, honeycomb, legs, middle-leg holes and support). |
| `spec.md` | Project spec (goal, design, constraints, parameters). |
| `plan.md` | Implementation plan (milestones, approach, next steps). |

Exported artifacts (e.g. `*.stl`, `*.3mf`) are generated from the corresponding `.scad` files.

## How to use

1. **Choose a variant**:
   - **Rectangle**: Open `emersed_anubias_platform_rectangle.scad`. Set `platform_width`, `platform_length`, `platform_height` (thickness), `rim_width`, `leg_length`, `leg_max_spacing`, and honeycomb parameters. Render and export STL/3MF.
   - **Polygon**: Open `emersed_anubias_platform_polygon.scad`. Set `platform_points` to your polygon (list of [x,y]). Set `hexagon_width`, `hexagon_edge_separation`. Optionally set `middle_leg_positons` and `middle_leg_lengths` for middle legs. Render and export.
   - **Container-specific**: Open the Glad or Rubbermaid file; adjust if needed and export.

2. **Print orientation**: Print **upside down** — platform on the build plate, legs extending upward. This avoids supports under the platform and gives a clean top surface for plants.

3. **Use**: Place the printed platform on your container (filled with nutrient water) so the legs sit on the rim or bottom. Anubias sit on the platform; roots grow through the honeycomb into the water.

## Parameters (summary)

- **Platform**: `platform_thickness`; rectangle: `platform_width`, `platform_length`, `platform_height`; polygon: `platform_points`.
- **Rim**: `rim_width` (leg_radius = rim_width/2, leg_tip_radius = rim_width/4).
- **Legs**: `leg_length`, `leg_max_spacing` (max spacing along edges).
- **Honeycomb**: Rectangle uses `hex_radius`, `hex_spacing_factor`; polygon uses `hexagon_width` (edge-to-edge), `hexagon_edge_separation`.
- **Middle legs (polygon)**: `middle_leg_positons` (list of [x,y]), `middle_leg_lengths` (one per position).

See `spec.md` for full parameter and design details.

## Design notes

- **Honeycomb**: Hexagon holes allow roots through and keep the structure light; edge separation can be tuned (e.g. as a multiple of printer line width).
- **Rim**: Solid border so legs land on stable material; no offset of leg positions—legs are centered on the platform outline.
- **Middle legs**: For large platforms or uneven container bottoms, add middle legs; each gets a large hexagon hole with a 6-triangle support under the leg.

## See also

- `spec.md` for detailed design, constraints, and parameters
- `plan.md` for implementation steps and milestones
