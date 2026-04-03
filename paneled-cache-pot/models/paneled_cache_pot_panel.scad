// Paneled cache pot base panel.

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

cache_pot_panel_flat_on_bed(
  inside_radius = inside_radius,
  min_wall_thickness = min_wall_thickness,
  outside_height = outside_height,
  num_panels = num_panels,
  outside_radius = outside_radius,
  panel_thickness = panel_thickness
);
//color("red") panel();
//color("yellow") core();
