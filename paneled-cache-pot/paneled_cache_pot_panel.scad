// Paneled cache pot base panel.

// ---------- Public parameters (mm) ----------
inside_radius = 75 / 2;
inside_height = 110;
min_wall_thickness = 2.5;
bottom_thickness = 2.5;
bottom_edge_width = 10;
num_panels = 8;
panel_thickness = 2.5;

// ---------- Resolution ----------
$fa = 1;
$fs = 1;

// ---------- Derived ----------
outside_height = inside_height + bottom_thickness;
outside_radius = (inside_radius + min_wall_thickness) / cos(180 / num_panels);

module outside_cylinder() {
  cylinder(outside_height, outside_radius, outside_radius, $fn = num_panels);
}

module inside_cutout() {
  translate([0, 0, bottom_thickness])
    cylinder(inside_height + 1, inside_radius, inside_radius);
  translate([0, 0, -0.5 * bottom_thickness])
    cylinder(2 * bottom_thickness, inside_radius - bottom_edge_width, inside_radius - bottom_edge_width);
}

module core() {
  difference() {
    outside_cylinder();
    inside_cutout();
  }
}

module panel() {
  difference() {
    cylinder(outside_height, outside_radius + panel_thickness, outside_radius + panel_thickness, $fn = num_panels);
    translate([0, 0, -1])
      cylinder(outside_height + 2, outside_radius, outside_radius, $fn = num_panels);
    translate([-(outside_radius + panel_thickness + 1), 0, -1])
      cube([2 * (outside_radius + panel_thickness + 1), 2 * (outside_radius + panel_thickness + 1), outside_height + 2]);
    rotate([0, 0, 180 - 360 / num_panels])
      translate([-(outside_radius + panel_thickness + 1), 0, -1])
        cube([2 * (outside_radius + panel_thickness + 1), 2 * (outside_radius + panel_thickness + 1), outside_height + 2]);
  }
}

module panel_flat_on_bed() {
  translate([outside_height / 2, 0, -(inside_radius + min_wall_thickness)])
    rotate([0, -90, 0])
      rotate([0, 0, 180 / num_panels])
        panel();
}

panel_flat_on_bed();
//color("red") panel();
//color("yellow") core();
