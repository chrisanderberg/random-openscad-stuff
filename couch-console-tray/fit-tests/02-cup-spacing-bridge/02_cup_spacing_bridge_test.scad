use <../../lib/project/console_tray.scad>;
include <../../lib/project/params.scad>;

bridge_plate_t = 2.4;
bridge_depth = plug_top_d + 20;
bridge_row_pitch = bridge_depth + 18;

for (i = [0 : len(test_spacing_values) - 1]) {
  spacing_value = test_spacing_values[i];
  cup_y = 0;

  translate([0, i * bridge_row_pitch, 0]) {
    translate([0, cup_y, 0])
      cube([spacing_value + plug_top_d + 20, bridge_depth, bridge_plate_t], center = true);

    cup_holder_pair(
      spacing = spacing_value,
      cup_y = cup_y,
      top_d = plug_top_d,
      bottom_d = plug_bottom_d,
      h = plug_h
    );
  }
}
