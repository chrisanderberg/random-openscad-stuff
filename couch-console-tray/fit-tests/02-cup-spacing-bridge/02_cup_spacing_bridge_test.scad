use <../../lib/project/console_tray.scad>;
include <../../lib/project/params.scad>;

bridge_plate_t = tray_floor_total_t(tray_floor_t, cup_rim_h);
spacing_test = cup_spacing;
cup_y = 0;
relief_d = cup_rim_relief_d(plug_top_d, cup_rim_w);
pad_margin = 6;
pad_d = relief_d + 2 * pad_margin;
bridge_strap_w = 24;
plug_embed_h = max(cup_rim_h + 1, 1);

difference() {
  linear_extrude(height = bridge_plate_t)
    union() {
      for (x = [-spacing_test / 2, spacing_test / 2]) {
        translate([x, cup_y])
          circle(d = pad_d, $fn = 96);
      }

      square([spacing_test, bridge_strap_w], center = true);
    }

  // Leave annular pads instead of solid caps above the hollow plug shells.
  for (x = [-spacing_test / 2, spacing_test / 2]) {
    translate([x, cup_y, -0.01])
      cylinder(
        d = max(plug_top_d - 2 * plug_shell_t, 0),
        h = bridge_plate_t + 0.02,
        center = false,
        $fn = 96
      );
  }

  if (cup_rim_w > 0 && cup_rim_h > 0) {
    for (x = [-spacing_test / 2, spacing_test / 2]) {
      translate([x, cup_y, -0.01])
        cylinder(
          d = cup_rim_relief_d(plug_top_d, cup_rim_w),
          h = cup_rim_h + 0.02,
          center = false,
          $fn = 96
        );
    }
  }
}

hollow_cup_holder_pair(
  spacing = spacing_test,
  cup_y = cup_y,
  top_d = plug_top_d,
  bottom_d = plug_bottom_d,
  h = plug_h,
  shell_t = plug_shell_t,
  embed_h = plug_embed_h
);
