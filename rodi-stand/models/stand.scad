// RO/DI Water Filter Stand
// Designed for 3D printing on a 256x256x256 mm build plate

use <../lib/project/mount_ring_module.scad>;

// ---------- Public parameters (mm) ----------
// Base dimensions (full build plate).
base_width = 250;
base_depth = 250;
base_thickness = 15;
base_front_corner_cut = 25;
base_back_corner_cut = 50;

// Mounting surface dimensions (shared by stand and mount plates).
mount_width = 100; // Width of the mounting surface.
mount_height = 200; // Height of mounting surface (adjustable).
base_glueing_surface_thickness = 6; // Thickness of mounting surface on the base.

// Screw parameters (shared by mount ring and mount plates).
screw_spacing = 30; // Horizontal spacing between screw holes.

// Stand positioning.
stand_offset_from_back = 40; // Distance from back edge of base.
stand_position_x = base_width / 2; // Center of base width-wise.

// Honeycomb pattern parameters.
honeycomb_width = 34;
honeycomb_margin = 40; // Margin from front and side edges of base.
honeycomb_back_margin = 80; // Distance from back edge - keeps back solid for stand mounting.

// Reinforcement gusset dimensions (optional - set to 0 to disable).
gusset_depth = 40; // Forward extension from mounting surface.
gusset_thickness = 6; // Thickness of gussets.
top_surface_angle = 45; // Angle of the top surface in degrees (0 = flat, positive = angled back).

// Mount ring parameters.
mount_ring_outer_diameter = 68;
mount_ring_inner_diameter = 60.5;
mount_ring_height = 20;
mount_surface_width = 65;
mount_surface_extension = 20;
mount_opening_angle = 120;
screw_wall_width = 12;
screw_hole_diameter = 4.5; // Mount ring screw hole diameter.
screw_access_diameter = 10;

// ---------- Resolution ----------
$fa = 1;
$fs = 1;

// ---------- Derived ----------
honeycomb_radius = (honeycomb_width / 2) / cos(30); // Radius of each hexagon (circumradius - distance from center to vertex).

// Calculate stand position.
stand_x = stand_position_x;
stand_y = base_depth - stand_offset_from_back - base_glueing_surface_thickness / 2;

module hexagon(radius) {
    // Create a regular hexagon
    // radius is the distance from center to vertex
    rotate([0, 0, 30])
    linear_extrude(height = base_thickness + 1) {
        circle(radius, $fn = 6);
    }
}

module honeycomb_pattern() {
    // Generate a tight honeycomb pattern where hexagons touch (like infill)
    // Hexagons are offset in alternating rows for true honeycomb pattern
    // For touching hexagons: horizontal spacing = radius * sqrt(3), vertical = radius * 1.5
    hex_apothem = honeycomb_radius * sqrt(3) / 2; // Distance from center to edge
    hex_horizontal_spacing = honeycomb_radius * sqrt(3); // Center-to-center horizontal (same row)
    hex_vertical_spacing = honeycomb_radius * 1.5; // Center-to-center vertical (adjacent rows)
    hex_row_offset = honeycomb_radius * sqrt(3) / 2; // Horizontal offset for alternating rows
    
    // Calculate pattern area (only front portion, not near back where stand mounts)
    pattern_width = base_width - 2 * honeycomb_margin;
    pattern_depth = base_depth - honeycomb_margin - honeycomb_back_margin; // Only front portion
    
    // Calculate how many hexagons fit
    num_cols = floor(pattern_width / hex_horizontal_spacing) + 2; // Extra columns for offset rows
    num_rows = floor(pattern_depth / hex_vertical_spacing) + 1;
    
    // Start position (front and centered)
    start_x = honeycomb_margin;
    start_y = honeycomb_margin;
    
    // Generate hexagons in honeycomb pattern (only in front area)
    for (row = [0 : num_rows - 1]) {
        y_pos = start_y + row * hex_vertical_spacing;
        // Only generate rows that are in the front area
        if (y_pos <= base_depth - honeycomb_back_margin) {
            // Offset every other row for honeycomb pattern
            x_offset = (row % 2 == 0) ? 0 : hex_row_offset;
            for (col = [0 : num_cols - 1]) {
                x_pos = start_x + col * hex_horizontal_spacing + x_offset;
                // Only create hexagon if it's within the horizontal bounds
                if (x_pos >= honeycomb_margin && x_pos <= base_width - honeycomb_margin) {
                    translate([x_pos, y_pos, -0.5])
                        hexagon(honeycomb_radius * 0.8);
                }
            }
        }
    }
}

module base() {
    // Base as a full square with honeycomb pattern cut from the middle
    difference() {
        // Full square base as extruded polygon (ready for rounded corners later)
        linear_extrude(height = base_thickness) {
            polygon(points = [
                [0, base_front_corner_cut], // Front left corner
                [base_front_corner_cut, 0],  // Front left corner
                [base_width - base_front_corner_cut, 0],              // Front right corner
                [base_width, base_front_corner_cut],              // Front right corner
                [base_width, base_depth - base_back_corner_cut],     // Back right corner
                [base_width - base_back_corner_cut, base_depth],     // Back right corner
                [base_back_corner_cut, base_depth],              // Back left corner
                [0, base_depth - base_back_corner_cut]              // Back left corner
            ]);
        }
        
        // Cut honeycomb pattern from the middle
        honeycomb_pattern();
    }
}

module angled_top_cut() {
    // Cut angled top surface using a rotated cube
    // Create cube, rotate around X axis, then translate along Z axis
    translate([0, -base_glueing_surface_thickness / 2, mount_height])
        rotate([-top_surface_angle, 0, 0])
            translate([-mount_width, -gusset_depth, 0])
                cube([mount_width * 2, gusset_depth * 3, gusset_depth * 3]);
}

module mounting_stand() {
    // Create the gluing surface and gussets as cubes at origin
    // Geometry is created with back edge at Y=0, centered at X=0, starting at Z=0
    difference() {
        union() {
            // Mounting surface (flat wall-like surface on base - mount plate glues to this)
            // Positioned so back edge is at Y=0, centered at X=0
            translate([-mount_width / 2, -base_glueing_surface_thickness / 2, 0])
                cube([mount_width, base_glueing_surface_thickness, mount_height]);
            
            // Reinforcement gussets on both sides of the mounting surface
            // Gussets are simple cubes extending forward from the mounting surface
            if (gusset_thickness > 0) {
                // Left gusset - extends forward from left edge of mounting surface
                translate([-mount_width / 2, -base_glueing_surface_thickness / 2, 0])
                    cube([gusset_thickness, gusset_depth + base_glueing_surface_thickness, mount_height]);
                
                // Right gusset - extends forward from right edge of mounting surface
                translate([mount_width / 2 - gusset_thickness, -base_glueing_surface_thickness / 2, 0])
                    cube([gusset_thickness, gusset_depth + base_glueing_surface_thickness, mount_height]);
            }
        }
        
        // Cut angled top surface
        angled_top_cut();
    }
}

module stand() {
    base();
    // Translate mounting stand to correct position
    translate([stand_x, stand_y, base_thickness])
        mounting_stand();
}

// ============================================================================
// Mount Ring - for mounting RO/DI unit
// ============================================================================


// ============================================================================
// Mount Plates - extend mounting surface height beyond build plate limits
// ============================================================================

// Mount plate parameters
plate_insert_diameter = 5.6; // Mount plate screw hole diameter (different from mount ring)
plate_insert_depth = 11;
plate_insert_back_wall_thickness = 3;
mount_thickness = plate_insert_depth + plate_insert_back_wall_thickness; // Thickness of the mount plate (separate part that glues to base)
plate_screw_hole_vertical_spacing = 195;
plate_screw_bottom_hole_spacing = 110;
plate_screw_hole_top_spacing = 20;

module plate_screw_hole(hole_diameter) {
    translate([0, -plate_insert_back_wall_thickness, 0])
    rotate([-90, 0, 0])
    cylinder(mount_thickness, hole_diameter / 2, hole_diameter / 2);
}

module mount_plate() {
    // Mount plate module
    // When printed on its side, this will have:
    // - Height (Z): mount_thickness (10mm) - layers will be vertical in final assembly
    // - Width (Y): mount_width (100mm) - matches stand mounting surface
    // - Length (X): length parameter
    // 
    // For printing: rotate 90° around X axis to lay on its side, then 45° around Z for diagonal
    difference() {
        cube([plate_screw_hole_top_spacing + plate_screw_bottom_hole_spacing + plate_screw_hole_vertical_spacing, mount_thickness, mount_width]);
        translate([plate_screw_hole_top_spacing, 0, mount_width / 2 - screw_spacing / 2])
            plate_screw_hole(plate_insert_diameter);
        translate([plate_screw_hole_top_spacing, 0, mount_width / 2 + screw_spacing / 2])
            plate_screw_hole(plate_insert_diameter);
        translate([plate_screw_hole_top_spacing + plate_screw_hole_vertical_spacing, 0, mount_width / 2 - screw_spacing / 2])
            plate_screw_hole(plate_insert_diameter);
        translate([plate_screw_hole_top_spacing + plate_screw_hole_vertical_spacing, 0, mount_width / 2 + screw_spacing / 2])
            plate_screw_hole(plate_insert_diameter);
    }
}

module test_mount_plate() {
    // Mount plate module
    // When printed on its side, this will have:
    // - Height (Z): mount_thickness (10mm) - layers will be vertical in final assembly
    // - Width (Y): mount_width (100mm) - matches stand mounting surface
    // - Length (X): length parameter
    // 
    // For printing: rotate 90° around X axis to lay on its side, then 45° around Z for diagonal
    difference() {
        cube([plate_screw_hole_top_spacing * 2, mount_thickness, mount_width]);
        translate([plate_screw_hole_top_spacing, 0, mount_width / 2 - screw_spacing / 2])
            plate_screw_hole(plate_insert_diameter);
        translate([plate_screw_hole_top_spacing, 0, mount_width / 2 + screw_spacing / 2])
            plate_screw_hole(plate_insert_diameter);
    }
}

// ============================================================================
// Main render - uncomment what you want to print
// ============================================================================

//stand();
//mount_ring();
mount_plate();
//test_mount_plate();
//mounting_stand();
//angled_top_cut();
