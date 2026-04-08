use <../../lib/project/console_tray.scad>;
include <../../lib/project/params.scad>;

// Rear tongue thickness coupons.
for (i = [0 : len(test_rear_tongue_ts) - 1]) {
  translate([i * (rear_tongue_w / 3 + 12), 0, 0])
    cube([rear_tongue_w / 3, rear_tongue_depth, test_rear_tongue_ts[i]], center = false);
}

// Cup plug diameter coupons.
for (i = [0 : len(test_plug_top_ds) - 1]) {
  translate([i * (max(test_plug_top_ds) + 18), rear_tongue_depth + 30, 0])
    cup_holder_plug(
      top_d = test_plug_top_ds[i],
      bottom_d = plug_bottom_d,
      h = 18
    );
}
