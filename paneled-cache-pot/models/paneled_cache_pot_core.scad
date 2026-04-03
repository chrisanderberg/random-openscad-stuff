// Paneled cache pot core.

use <../lib/project/cache_pot_geometry.scad>;

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
outside_height = cache_pot_outside_height(inside_height, bottom_thickness);
outside_radius = cache_pot_outside_radius(inside_radius, min_wall_thickness, num_panels);

//color("blue") panel_flat_on_bed();
//color("red") panel();
color("yellow")
  cache_pot_core(
    inside_height = inside_height,
    inside_radius = inside_radius,
    bottom_thickness = bottom_thickness,
    bottom_edge_width = bottom_edge_width,
    outside_height = outside_height,
    outside_radius = outside_radius,
    num_panels = num_panels
  );
