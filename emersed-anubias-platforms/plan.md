# Plan

## Milestones

- **Rectangle platform**: Rectangular platform with honeycomb hexagon grid, solid rim, and conical legs (corners + evenly spaced along all four edges). Print orientation: upside down (platform on bed, legs up).
- **Polygon platform**: Arbitrary-polygon variant using `platform_points`; rim via polygon offset (radius = leg_radius); legs on vertices and along each edge with no offset; same honeycomb and leg parameters. Optional extraction to `lib/` for shared logic.
- **Middle legs**: Optional middle legs for large or uneven containers—positions and per-leg lengths; at each position a large hexagon hole (outer ring + inner cut) and a support structure (center cylinder + 6 radial cubes at 60°, intersected with outer hexagon) forming 6 triangles under the leg.
- **Container variants**: Glad, Rubbermaid, and other container-specific parameter sets or wrapper files; export STL/3MF per variant.
- **Validation**: Confirm container dimensions per variant; validate leg placement and rim fit; export final STLs (and 3MF where needed).

## Approach (steps taken)

1. **Rectangle**: Single file with platform as hull of four corner cylinders; rim as difference of outer and inner hull-of-cylinders; honeycomb pattern cut from platform; legs (truncated cones) at corners and along edges (spacing ≤ leg_max_spacing). Derived leg_radius = rim_width/2, leg_tip_radius = rim_width/4.
2. **Rim and legs**: Rim defined as its own module (outer shape minus inner hole). Legs placed directly on platform outline (vertices and edge points)—no extra offset—so rim provides landing surface.
3. **Polygon**: New file (and optional lib) with polygon platform, offset-based rim (positive and negative offset by leg_radius), honeycomb over bounding box. Hexagon params: hexagon_width, hexagon_edge_separation. Leg placement along polygon edges using edge length and leg_max_spacing.
4. **Middle-leg holes**: At each middle_leg_position, add a “hole” structure: outer solid hexagon (width 2×hexagon_width + 3×hexagon_edge_separation), inner cut (2×hexagon_width + hexagon_edge_separation); cut inner from platform and add the outer ring so the hole has a supporting edge.
5. **Middle-leg support**: Inside each hole, add support = intersection of (outer hexagon) with (center cylinder + 6 cubes at 60°). Result: 6 triangles filling the hexagon under the leg.
6. **Container-specific**: Separate `.scad` files or parameter blocks for Glad, Rubbermaid, etc., calling rectangle or polygon platform with fixed dimensions and optional middle legs; export STL/3MF.

## Next Steps

- Confirm and document container dimensions for each variant (Glad, Rubbermaid, etc.).
- Validate leg count and spacing against rim fit for each container.
- Export and name final STL/3MF per variant; note print orientation (upside down) in docs or filename if helpful.

## Open Questions

- (None at this time.)

## Assumptions

- Leg radius equals rim offset (leg_radius = rim_width/2); rim width is effectively 2× that offset.
- Honeycomb centering for polygon is not required; grid can start from bounding box.
- Middle leg support uses the same outer hexagon size as the hole (2×hexagon_width + 3×hexagon_edge_separation) for a clean intersection.
