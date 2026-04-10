use <../../lib/project/console_tray.scad>;
include <../../lib/project/params.scad>;

// Print one half, then mirror it in the slicer or by setting mirror_part = true
// for the matching opposite side.
mirror_part = false;

half_cup_plug_side_to_side_slice_variant(
  tray_w = tray_w,
  tray_d = tray_d,
  front_extension = front_extension,
  tray_corner_r = tray_corner_r,
  tray_floor_t = tray_floor_t,
  tray_wall_h = tray_wall_h,
  top_wall_w = top_wall_w,
  support_lip_drop = support_lip_drop,
  support_lip_w = support_lip_w,
  front_lip_forward_shift = front_lip_forward_shift,
  front_lip_back_extra = front_lip_back_extra,
  front_lip_bottom_back_extra = front_lip_bottom_back_extra,
  side_lip_inner_extra = side_lip_inner_extra,
  side_lip_bottom_inner_extra = side_lip_bottom_inner_extra,
  rear_gap_w = rear_gap_w,
  rear_tongue_w = rear_tongue_w,
  rear_tongue_depth = rear_tongue_depth,
  rear_tongue_t = rear_tongue_t,
  cup_spacing = cup_spacing,
  cup_y_from_front = cup_y_from_front,
  plug_top_d = plug_top_d,
  plug_bottom_d = plug_bottom_d,
  plug_h = plug_h,
  plug_shell_t = plug_shell_t,
  cup_rim_w = cup_rim_w,
  cup_rim_h = cup_rim_h,
  slice_w = test_side_to_side_slice_w,
  mirror_x = mirror_part
);
