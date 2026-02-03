// Emersed Anubias Platform
// Designed to be printed upside down (platform on bed, legs extending upward)

// ---------- Public parameters (mm) ----------
// Platform dimensions.
platform_width = 220;
platform_length = 140;
platform_height = 2;

// Rim width (solid border around edges).
rim_width = 5;

// Leg dimensions (cones: radius at platform, smaller radius at tip).
leg_height = 20;
leg_max_spacing = 50;

// Honeycomb parameters.
hex_radius = 7; // Radius of each hexagon (circumradius - distance from center to vertex).
hex_spacing_factor = 1.1; // Spacing between hexagons (1.0 = touching, >1.0 = gaps).

// ---------- Resolution ----------
$fa = 1;
$fs = 1;

// ---------- Derived ----------
leg_radius = rim_width / 2;
leg_tip_radius = rim_width / 4; // Radius at the bottom of the leg (tip).

// Calculate honeycomb spacing.
hex_apothem = hex_radius * sqrt(3) / 2; // Distance from center to edge.
hex_horizontal_spacing = hex_radius * sqrt(3) * hex_spacing_factor; // Center-to-center horizontal.
hex_vertical_spacing = hex_radius * 1.5 * hex_spacing_factor; // Center-to-center vertical.
hex_row_offset = hex_radius * sqrt(3) / 2 * hex_spacing_factor; // Horizontal offset for alternating rows.

module hexagon(radius) {
    // Create a regular hexagon.
    rotate([0, 0, 30])
    linear_extrude(height = platform_height + 1) {
        circle(radius, $fn = 6);
    }
}

module platform_shape() {
    // Create platform shape as hull of 4 cylinders at the corners.
    hull() {
        // Front left.
        translate([leg_radius, leg_radius, 0])
            cylinder(h = platform_height, r = leg_radius);
        
        // Front right.
        translate([platform_width - leg_radius, leg_radius, 0])
            cylinder(h = platform_height, r = leg_radius);
        
        // Back left.
        translate([leg_radius, platform_length - leg_radius, 0])
            cylinder(h = platform_height, r = leg_radius);
        
        // Back right.
        translate([platform_width - leg_radius, platform_length - leg_radius, 0])
            cylinder(h = platform_height, r = leg_radius);
    }
}

module inner_platform_shape() {
    // Create inner platform shape as hull of 4 cylinders (for rim cutout).
    // This is 2 * rim_width smaller in x and y dimensions.
    inner_width = platform_width - 2 * rim_width;
    inner_length = platform_length - 2 * rim_width;
    
    hull() {
        // Front left.
        translate([rim_width + leg_radius, rim_width + leg_radius, 0])
            cylinder(h = platform_height + 1, r = leg_radius);
        
        // Front right.
        translate([rim_width + inner_width - leg_radius, rim_width + leg_radius, 0])
            cylinder(h = platform_height + 1, r = leg_radius);
        
        // Back left.
        translate([rim_width + leg_radius, rim_width + inner_length - leg_radius, 0])
            cylinder(h = platform_height + 1, r = leg_radius);
        
        // Back right.
        translate([rim_width + inner_width - leg_radius, rim_width + inner_length - leg_radius, 0])
            cylinder(h = platform_height + 1, r = leg_radius);
    }
}

module rim() {
    // Create a rim by cutting a smaller hull of cylinders from the platform shape.
    difference() {
        // Outer platform shape.
        platform_shape();
        
        // Inner hull of cylinders (2 * rim_width smaller in x and y, larger in z to cut through).
        translate([0, 0, -0.5])
            inner_platform_shape();
    }
}

module honeycomb_pattern() {
    // Generate a honeycomb pattern; can extend past edges since rim will cover them.
    // Calculate how many hexagons fit (generous estimate).
    num_cols = floor(platform_width / hex_horizontal_spacing) + 3;
    num_rows = floor(platform_length / hex_vertical_spacing) + 3;
    
    // Center the pattern.
    // Calculate actual pattern bounds for centering.
    actual_pattern_width = (num_cols - 1) * hex_horizontal_spacing + hex_row_offset;
    actual_pattern_length = (num_rows - 1) * hex_vertical_spacing;
    
    // Center the pattern.
    start_x = (platform_width - actual_pattern_width) / 2;
    start_y = (platform_length - actual_pattern_length) / 2;
    
    // Generate hexagons in honeycomb pattern.
    for (row = [0 : num_rows - 1]) {
        y_pos = start_y + row * hex_vertical_spacing;
        // Offset every other row for honeycomb pattern.
        x_offset = (row % 2 == 0) ? 0 : hex_row_offset;
        
        for (col = [0 : num_cols - 1]) {
            x_pos = start_x + col * hex_horizontal_spacing + x_offset;
            
            // Create hexagon; no bounds checking needed, rim will cover edges.
            translate([x_pos, y_pos, -0.5])
                hexagon(hex_radius);
        }
    }
}

module corner_leg() {
    // Create a cone leg: radius at platform, smaller radius at tip.
    // Since we print upside down, the leg extends upward from the platform.
    translate([0, 0, platform_height])
        cylinder(h = leg_height, r1 = leg_radius, r2 = leg_tip_radius);
}

module side_legs(side_length, is_horizontal) {
    // Place evenly spaced legs along a side.
    // side_length: length of the side.
    // is_horizontal: true for front/back sides, false for left/right sides.
    
    // Available space between corner legs.
    available_space = side_length - 2 * leg_radius;
    
    // Calculate number of intermediate legs needed.
    num_legs = floor(available_space / leg_max_spacing);
    
    if (num_legs > 0) {
        // Calculate spacing between legs (including gaps to corners).
        spacing = available_space / (num_legs + 1);
        
        // Place legs along the side.
        for (i = [1 : num_legs]) {
            position = leg_radius + i * spacing;
            
            if (is_horizontal) {
                // Front or back side - legs positioned along X axis.
                translate([position, 0, 0])
                    corner_leg();
            } else {
                // Left or right side - legs positioned along Y axis.
                translate([0, position, 0])
                    corner_leg();
            }
        }
    }
}

module platform() {
    union() {
        // Platform with honeycomb pattern cut out
        difference() {
            // Main platform shape (hull of 4 cylinders)
            platform_shape();
            
            // Cut honeycomb pattern (can extend past edges)
            honeycomb_pattern();
        }
        
        // Add rim. to ensure structural integrity at edges
        rim();
        
        // Add four corner legs
        // Position legs at the corners where the cylinders are
        // Front left.
        translate([leg_radius, leg_radius, 0])
            corner_leg();
        
        // Front right.
        translate([platform_width - leg_radius, leg_radius, 0])
            corner_leg();
        
        // Back left.
        translate([leg_radius, platform_length - leg_radius, 0])
            corner_leg();
        
        // Back right.
        translate([platform_width - leg_radius, platform_length - leg_radius, 0])
            corner_leg();
        
        // Add legs along all four sides
        // Front side. (Y = leg_radius)
        translate([0, leg_radius, 0])
            side_legs(platform_width, true);
        
        // Back side. (Y = platform_length - leg_radius)
        translate([0, platform_length - leg_radius, 0])
            side_legs(platform_width, true);
        
        // Left side. (X = leg_radius)
        translate([leg_radius, 0, 0])
            side_legs(platform_length, false);
        
        // Right side. (X = platform_width - leg_radius)
        translate([platform_width - leg_radius, 0, 0])
            side_legs(platform_length, false);
    }
}

// Render the platform
platform();
