// Shared paneled cache pot geometry helpers.

function cache_pot_outside_height(inside_height, bottom_thickness) =
  inside_height + bottom_thickness;

function cache_pot_outside_radius(inside_radius, min_wall_thickness, num_panels) =
  (inside_radius + min_wall_thickness) / cos(180 / num_panels);

function cache_pot_panel_extra_radius(panel_thickness, num_panels) =
  panel_thickness / cos(180 / num_panels);

function cache_pot_panel_width(outside_radius, panel_thickness, num_panels) =
  (outside_radius + cache_pot_panel_extra_radius(panel_thickness, num_panels)) *
  2 * sin(180 / num_panels);

module cache_pot_outside_cylinder(outside_height, outside_radius, num_panels) {
  cylinder(outside_height, outside_radius, outside_radius, $fn = num_panels);
}

module cache_pot_inside_cutout(
  inside_height,
  inside_radius,
  bottom_thickness,
  bottom_edge_width
) {
  translate([0, 0, bottom_thickness])
    cylinder(inside_height + 1, inside_radius, inside_radius);
  translate([0, 0, -0.5 * bottom_thickness])
    cylinder(
      2 * bottom_thickness,
      inside_radius - bottom_edge_width,
      inside_radius - bottom_edge_width
    );
}

module cache_pot_core(
  inside_height,
  inside_radius,
  bottom_thickness,
  bottom_edge_width,
  outside_height,
  outside_radius,
  num_panels
) {
  difference() {
    cache_pot_outside_cylinder(outside_height, outside_radius, num_panels);
    cache_pot_inside_cutout(
      inside_height,
      inside_radius,
      bottom_thickness,
      bottom_edge_width
    );
  }
}

module cache_pot_panel_shell(
  outside_height,
  outside_radius,
  panel_thickness,
  num_panels
) {
  difference() {
    cylinder(
      outside_height,
      outside_radius + panel_thickness,
      outside_radius + panel_thickness,
      $fn = num_panels
    );
    translate([0, 0, -1])
      cylinder(outside_height + 2, outside_radius, outside_radius, $fn = num_panels);
    translate([-(outside_radius + panel_thickness + 1), 0, -1])
      cube([
        2 * (outside_radius + panel_thickness + 1),
        2 * (outside_radius + panel_thickness + 1),
        outside_height + 2
      ]);
    rotate([0, 0, 180 - 360 / num_panels])
      translate([-(outside_radius + panel_thickness + 1), 0, -1])
        cube([
          2 * (outside_radius + panel_thickness + 1),
          2 * (outside_radius + panel_thickness + 1),
          outside_height + 2
        ]);
  }
}

module cache_pot_panel_flat_on_bed(
  inside_radius,
  min_wall_thickness,
  outside_height,
  num_panels,
  outside_radius,
  panel_thickness
) {
  translate([outside_height / 2, 0, -(inside_radius + min_wall_thickness)])
    rotate([0, -90, 0])
      rotate([0, 0, 180 / num_panels])
        cache_pot_panel_shell(
          outside_height = outside_height,
          outside_radius = outside_radius,
          panel_thickness = panel_thickness,
          num_panels = num_panels
        );
}
