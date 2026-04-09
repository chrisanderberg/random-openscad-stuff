use <../../lib/project/console_tray.scad>;
include <../../lib/project/params.scad>;

// Print one half, then mirror it in the slicer or by setting mirror_part = true
// for the matching opposite side.
mirror_part = false;

half_perimeter_lip_fit_variant(
  tray_w = tray_w,
  tray_d = tray_d,
  tray_corner_r = tray_corner_r,
  support_lip_drop = support_lip_drop,
  support_lip_w = support_lip_w,
  rear_gap_w = rear_gap_w,
  rear_tongue_w = rear_tongue_w,
  mirror_x = mirror_part
);
