# Spec

## Goal

Create printable emersed anubias platforms sized to different container shapes. Emersed anubias is grown with leaves out of the water in a humid environment so plants get atmospheric CO2 and grow faster. The platform sits on a container filled with nutrient-rich water; anubias sit on the platform with roots extending through holes into the water below.

## Design

- **Platform**: A thin, open structure (honeycomb grid) with a solid rim. Shape is either rectangular or an arbitrary polygon to fit odd-shaped containers.
- **Honeycomb grid**: Hexagon holes (beehive-style) so roots can pass through. Grid parameters use hexagon width (edge-to-edge) and edge separation (gap between hexagons) so spacing can be reasoned about and tuned (e.g. as a multiple of printer line width).
- **Rim**: Solid border around the perimeter for structural integrity and for legs to attach. Rim is formed by offsetting the platform outline outward and inward; leg radius defines the offset so legs sit on the rim.
- **Legs**: Truncated cones (same base and tip radius for all legs). Base radius = rim_width/2, tip radius = rim_width/4 (derived). Legs are placed directly on platform vertices and evenly along edges (spacing ≤ leg_max_spacing). For large or uneven containers, optional middle legs can be added at given positions with per-leg lengths.
- **Middle-leg holes**: At each middle leg position, a large hexagon “hole” is cut and replaced with a supporting structure: an outer hexagon ring (supporting edge) and an inner support made of a center cylinder plus 6 radial “spokes” (cubes at 60°), intersected with the outer hexagon, giving 6 triangles that support the middle leg.
- **Print orientation**: Designed to print upside down—platform on the build plate, legs extending upward.

## Constraints

- Stable rim support on container edges; legs must land on solid rim (no offset from platform outline).
- Light, open structure for water flow and plant roots; honeycomb only in the interior, rim stays solid.
- Units: mm. Coordinate system: Z up (per repo conventions).
- OpenSCAD: latest stable (not nightly).

## Outputs

- **Rectangle variant** (`emersed_anubias_platform_rectangle.scad`): Rectangular platform (width × length × height). Shape is hull of four corner cylinders; rim and inner hole are hulls of cylinders. Legs at corners and along all four edges.
- **Polygon variant** (`emersed_anubias_platform_polygon.scad`): Platform defined by `platform_points` (arbitrary polygon). Rim uses polygon offset (radius = leg_radius) for outer and inner boundary. Legs at vertices and along each edge; optional middle legs with hexagon holes and 6-triangle support. Shared logic may live in `lib/` (e.g. `platform_polygon_lib.scad`).
- **Container-specific variants**: Glad, Rubbermaid, etc. — parameter sets or small wrappers that call the rectangle or polygon platform with fixed dimensions and optional middle legs.
- Export artifacts: STL and/or 3MF as needed per variant.

## Parameters (summary)

- **Platform**: thickness; for rectangle — width, length, height; for polygon — `platform_points`.
- **Rim**: `rim_width` (solid border width; leg_radius = rim_width/2).
- **Legs**: `leg_length`, `leg_max_spacing` (max spacing along edges); tip radius = rim_width/4.
- **Honeycomb**: `hexagon_width` (edge-to-edge), `hexagon_edge_separation` (gap). Polygon variant may also define middle-leg hexagon sizes (outer = 2×hexagon_width + 3×edge_separation, inner hole = 2×hexagon_width + edge_separation).
- **Middle legs (polygon)**: `middle_leg_positions` (list of [x,y]), `middle_leg_lengths` (list of lengths, one per position).

## Notes

- Variants live in separate `.scad` files; outputs include multiple STL/3MF exports.
- Hexagon grid is not required to be centered for polygons; centering is optional and left to implementation/plan.
- Legs are not offset from platform points or edge lines; they are centered on those positions so the rim (from offset) provides the landing surface.
