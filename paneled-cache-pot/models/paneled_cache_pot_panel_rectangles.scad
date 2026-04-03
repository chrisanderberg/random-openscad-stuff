// Paneled cache pot rectangles panel.

use <../lib/project/cache_pot_geometry.scad>;

// ---------- Public parameters (mm) ----------
inside_radius = 75 / 2;
inside_height = 110;
min_wall_thickness = 2.5;
bottom_thickness = 2.5;
bottom_edge_width = 10;
num_panels = 8;
panel_thickness = 2.5;
groove_depth = 1.0;

// ---------- Resolution ----------
$fa = 1;
$fs = 1;

// ---------- Derived ----------
outside_height = cache_pot_outside_height(inside_height, bottom_thickness);
outside_radius = cache_pot_outside_radius(inside_radius, min_wall_thickness, num_panels);
panel_width = cache_pot_panel_width(outside_radius, panel_thickness, num_panels);

module panel_groove() {
    groove_x = outside_height / 4;
    groove_y = panel_width;
    translate([0, 0, panel_thickness * 1.5 - groove_depth]) cube([groove_x * 5 / 6, groove_y * 5 / 6, panel_thickness], center=true);
    translate([0, 0, panel_thickness * 1.5 - 2 * groove_depth]) cube([groove_x * 3 / 6, groove_y * 3 / 6, panel_thickness], center=true);
}

module grooved_panel() {
    groove_x = outside_height / 4;
    difference() {
        cache_pot_panel_flat_on_bed(
          inside_radius = inside_radius,
          min_wall_thickness = min_wall_thickness,
          outside_height = outside_height,
          num_panels = num_panels,
          outside_radius = outside_radius,
          panel_thickness = panel_thickness
        );
        translate([-1.5 * groove_x, 0, 0]) panel_groove();
        translate([-0.5 * groove_x, 0, 0]) panel_groove();
        translate([0.5 * groove_x, 0, 0]) panel_groove();
        translate([1.5 * groove_x, 0, 0]) panel_groove();
    }
}

grooved_panel();
//color("red") panel();
//color("yellow") core();
