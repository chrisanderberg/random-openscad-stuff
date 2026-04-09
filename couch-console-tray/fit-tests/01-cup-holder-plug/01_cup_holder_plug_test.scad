use <../../lib/project/console_tray.scad>;
include <../../lib/project/params.scad>;

// Single plug test model.
plug_top_d_test = plug_top_d;

cup_holder_plug(
  top_d = plug_top_d_test,
  bottom_d = plug_bottom_d,
  h = plug_h
);
