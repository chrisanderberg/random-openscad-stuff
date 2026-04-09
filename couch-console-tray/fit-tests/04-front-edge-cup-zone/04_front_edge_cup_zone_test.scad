use <../../lib/project/console_tray.scad>;
include <../../lib/project/params.scad>;

front_edge_cup_zone_variant(
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
  cup_spacing = cup_spacing,
  cup_y_from_front = cup_y_from_front,
  plug_top_d = plug_top_d,
  plug_bottom_d = plug_bottom_d,
  plug_h = plug_h,
  cup_rim_w = cup_rim_w,
  cup_rim_h = cup_rim_h,
  front_zone_depth = test_front_zone_depth
);
