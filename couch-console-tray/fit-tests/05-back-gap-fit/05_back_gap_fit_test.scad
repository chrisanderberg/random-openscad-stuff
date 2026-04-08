use <../../lib/project/console_tray.scad>;
include <../../lib/project/params.scad>;

back_gap_fit_variant(
  tray_w = tray_w,
  tray_d = tray_d,
  tray_corner_r = tray_corner_r,
  tray_floor_t = tray_floor_t,
  tray_wall_h = tray_wall_h,
  top_wall_w = top_wall_w,
  support_lip_drop = support_lip_drop,
  support_lip_w = support_lip_w,
  rear_gap_w = rear_gap_w,
  rear_tongue_w = rear_tongue_w,
  rear_tongue_depth = rear_tongue_depth,
  rear_tongue_t = rear_tongue_t,
  section_w = test_gap_section_w
);
