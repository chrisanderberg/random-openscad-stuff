use <../../lib/project/console_tray.scad>;
include <../../lib/project/params.scad>;

variant_spacing = max(test_plug_top_ds) + 20;

for (i = [0 : len(test_plug_top_ds) - 1]) {
  translate([i * variant_spacing, 0, 0])
    cup_holder_plug(
      top_d = test_plug_top_ds[i],
      bottom_d = plug_bottom_d,
      h = plug_h
    );
}
