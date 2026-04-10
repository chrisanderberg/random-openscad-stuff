use <../../lib/project/console_tray.scad>;
include <../../lib/project/params.scad>;

perimeter_frame_variant(
  tray_w = tray_w,
  tray_d = tray_d,
  tray_corner_r = tray_corner_r,
  frame_wall_w = test_frame_wall_w,
  tray_floor_t = tray_floor_t,
  support_lip_drop = support_lip_drop,
  support_lip_w = support_lip_w,
  front_lip_back_extra = front_lip_back_extra,
  front_lip_bottom_back_extra = front_lip_bottom_back_extra,
  rear_gap_w = rear_gap_w,
  rear_tongue_w = rear_tongue_w,
  rear_tongue_depth = rear_tongue_depth,
  rear_tongue_t = rear_tongue_t
);
