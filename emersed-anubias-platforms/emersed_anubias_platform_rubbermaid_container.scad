// Emersed Anubias Platform - Polygon Version
// Designed to be printed upside down (platform on bed, legs extending upward)
// Supports arbitrary polygon shapes defined by platform_points

// ---------- Public parameters (mm) ----------
// Platform shape parameters.
platform_thickness = 2;
platform_points = [[0, 15], [15, 0], [210, 0], [225, 15], [225, 130], [210, 145], [15, 145], [0, 130]]; // Example polygon; replace with your polygon.
rim_width = 5;
leg_length = 20;
leg_max_spacing = 50;

// Middle legs.
middle_leg_positons = [[56.25, 72.5], [112.5, 72.5], [168.755, 72.5]]; // Example positions; replace with your middle leg positions.
middle_leg_lengths = [18.5, 17, 18.5]; // Example lengths; replace with your middle leg lengths.

// Hexagon grid parameters.
hexagon_width = 10; // Size of each hexagon from one edge to opposite edge.
hexagon_edge_separation = 1.64; // Amount of space between hexagon edges.
middle_leg_hexagon_width = hexagon_width * 1.5;
// Total hexagon spacing will be hexagon_width + hexagon_edge_separation apart.

// ---------- Resolution ----------
$fa = 1;
$fs = 1;

// ---------- Derived ----------

// Leg dimensions (calculated from rim_width).
leg_radius = rim_width / 2;
leg_tip_radius = rim_width / 4;

// Hexagon calculations.
// hexagon_width is edge-to-edge distance, so circumradius = width / sqrt(3).
hex_radius = hexagon_width / sqrt(3);
// Center-to-center spacing: horizontal = sqrt(3) * radius, vertical = 1.5 * radius.
// Add edge separation to horizontal spacing.
hex_horizontal_spacing = hex_radius * sqrt(3) + hexagon_edge_separation;
hex_vertical_spacing = hex_radius * 1.5 + hexagon_edge_separation;
hex_row_offset = hex_radius * sqrt(3) / 2 + hexagon_edge_separation / 2; // Horizontal offset for alternating rows.

// ============================================================================
// Helper Functions
// ============================================================================

function polygon_bounds(points) = [
    [min([for (p = points) p[0]]), min([for (p = points) p[1]])],
    [max([for (p = points) p[0]]), max([for (p = points) p[1]])]
];

function edge_length(p1, p2) = sqrt(pow(p2[0] - p1[0], 2) + pow(p2[1] - p1[1], 2));

function edge_direction(p1, p2) = [p2[0] - p1[0], p2[1] - p1[1]];

function edge_normal(p1, p2) = 
    let(dir = edge_direction(p1, p2),
        len = sqrt(pow(dir[0], 2) + pow(dir[1], 2)))
    len > 0 ? [-dir[1] / len, dir[0] / len] : [0, 1];

// ============================================================================
// Modules
// ============================================================================

module hexagon(radius) {
    // Create a regular hexagon.
    rotate([0, 0, 30])
    linear_extrude(height = platform_thickness + 1) {
        circle(radius, $fn = 6);
    }
}

module platform_shape() {
    // Create platform shape from polygon.
    linear_extrude(height = platform_thickness) {
        polygon(platform_points);
    }
}

module rim() {
    // Create a rim by offsetting the polygon.
    // Outer edge: positive offset, Inner edge: negative offset.
    // Use rim_width / 4 since offset happens on both sides (total rim = 2 * offset).
    difference() {
        // Outer rim (expanded polygon).
        linear_extrude(height = platform_thickness) {
            offset(r = leg_radius) {
                polygon(platform_points);
            }
        }
        
        // Inner hole (contracted polygon).
        translate([0, 0, -0.5])
        linear_extrude(height = platform_thickness + 1) {
            offset(r = -leg_radius) {
                polygon(platform_points);
            }
        }
    }
}

module honeycomb_pattern() {
    // Generate a honeycomb pattern covering the polygon area.
    // Get bounding box for pattern generation.
    bounds = polygon_bounds(platform_points);
    min_x = bounds[0][0];
    min_y = bounds[0][1];
    max_x = bounds[1][0];
    max_y = bounds[1][1];
    
    width = max_x - min_x;
    height = max_y - min_y;
    
    // Calculate how many hexagons fit (generous estimate).
    num_cols = floor(width / hex_horizontal_spacing) + 3;
    num_rows = floor(height / hex_vertical_spacing) + 3;
    
    // Start position (top-left of bounding box).
    start_x = min_x;
    start_y = min_y;
    
    // Generate hexagons in honeycomb pattern.
    for (row = [0 : num_rows - 1]) {
        y_pos = start_y + row * hex_vertical_spacing;
        // Offset every other row for honeycomb pattern.
        x_offset = (row % 2 == 0) ? 0 : hex_row_offset;
        
        for (col = [0 : num_cols - 1]) {
            x_pos = start_x + col * hex_horizontal_spacing + x_offset;
            
            // Create hexagon - rim will cover edges anyway.
            translate([x_pos, y_pos, -0.5])
                hexagon(hex_radius);
        }
    }
}

module middle_leg_hexagon_hole() {
    // Create a hexagon hole for middle leg support.
    // Outer hexagon (solid) and inner hexagon (hole) create a supporting edge.
    // hexagon_width is edge-to-edge, so circumradius = width / sqrt(3).
    outer_width = middle_leg_hexagon_width + 2 * hexagon_edge_separation;
    inner_width = middle_leg_hexagon_width;
    
    outer_radius = outer_width / sqrt(3);
    inner_radius = inner_width / sqrt(3);
    
    difference() {
        // Outer solid hexagon (supporting edge).
        linear_extrude(height = platform_thickness) {
            rotate([0, 0, 30])
                circle(outer_radius, $fn = 6);
        }
        
        // Inner hole hexagon.
        translate([0, 0, -0.5])
        linear_extrude(height = platform_thickness + 1) {
            rotate([0, 0, 30])
                circle(inner_radius, $fn = 6);
        }
    }
}

module middle_leg_holes() {
    // Create hexagon holes at all middle leg positions.
    // This adds the supporting edge structure.
    for (leg_pos = middle_leg_positons) {
        translate([leg_pos[0], leg_pos[1], 0])
            middle_leg_hexagon_hole();
    }
}

module middle_leg_hole_cuts() {
    // Cut the inner hexagon holes from the platform.
    inner_width = middle_leg_hexagon_width;
    inner_radius = inner_width / sqrt(3);
    
    for (leg_pos = middle_leg_positons) {
        translate([leg_pos[0], leg_pos[1], -0.5])
        linear_extrude(height = platform_thickness + 1) {
            rotate([0, 0, 30])
                circle(inner_radius, $fn = 6);
        }
    }
}

module corner_leg() {
    // Create a cone leg: radius at platform, smaller radius at tip.
    // Since we print upside down, the leg extends upward from the platform.
    translate([0, 0, platform_thickness])
        cylinder(h = leg_length, r1 = leg_radius, r2 = leg_tip_radius);
}

module edge_legs(edge_start, edge_end) {
    // Place evenly spaced legs along an edge.
    // edge_start: [x, y] start point of edge.
    // edge_end: [x, y] end point of edge.
    
    edge_len = edge_length(edge_start, edge_end);
    
    // Available space along the edge.
    available_space = edge_len - 2 * leg_radius;
    
    // Calculate number of intermediate legs needed.
    num_legs = floor(available_space / leg_max_spacing);
    
    if (num_legs > 0) {
        // Calculate spacing between legs (including gaps to corners).
        spacing = available_space / (num_legs + 1);
        
        // Direction vector and unit vector along the edge.
        dir = edge_direction(edge_start, edge_end);
        dir_len = sqrt(pow(dir[0], 2) + pow(dir[1], 2));
        unit_dir = [dir[0] / dir_len, dir[1] / dir_len];
        
        // Place legs along the edge.
        for (i = [1 : num_legs]) {
            position = leg_radius + i * spacing;
            translate([edge_start[0] + unit_dir[0] * position, edge_start[1] + unit_dir[1] * position, 0])
                corner_leg();
        }
    }
}

module polygon_legs() {
    // Place legs at vertices and along edges.
    num_points = len(platform_points);
    for (i = [0 : num_points - 1]) {
        p1 = platform_points[i];
        p2 = platform_points[(i + 1) % num_points];
        
        // Leg at vertex.
        translate([p1[0], p1[1], 0])
            corner_leg();
        
        // Legs along edge.
        edge_legs(p1, p2);
    }
}

module middle_leg_support() {
    // Add supporting edge structure around middle legs.
    middle_leg_holes();
}

module middle_leg(leg_length) {
    // Create a middle leg with adjustable length.
    translate([0, 0, platform_thickness])
        cylinder(h = leg_length, r1 = leg_radius, r2 = leg_tip_radius);
}

module middle_legs() {
    // Place middle legs at specified positions and lengths.
    for (i = [0 : len(middle_leg_positons) - 1]) {
        leg_pos = middle_leg_positons[i];
        leg_len = middle_leg_lengths[i];
        translate([leg_pos[0], leg_pos[1], 0])
            middle_leg(leg_len);
    }
}

module platform() {
    // Main platform with honeycomb pattern and legs.
    difference() {
        platform_shape();
        honeycomb_pattern();
        middle_leg_hole_cuts();
    }
    rim();
    polygon_legs();
    middle_leg_support();
    middle_legs();
}


// Render the platform
platform();

// Render the rim
//rim();
