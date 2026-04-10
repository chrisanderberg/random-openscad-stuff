use <../../lib/project/console_tray.scad>;
include <../../lib/project/params.scad>;

top_rim_rabbet_corner_fit_variant(
  tray_w = tray_w,
  tray_d = tray_d,
  front_extension = front_extension,
  tray_corner_r = tray_corner_r,
  tray_floor_t = tray_floor_t,
  tray_wall_h = tray_wall_h,
  top_wall_w = top_wall_w,
  glue_rabbet_h = glue_rabbet_h,
  glue_rabbet_w = glue_rabbet_w,
  glue_rabbet_side_clearance = glue_rabbet_side_clearance,
  glue_rabbet_vertical_clearance = glue_rabbet_vertical_clearance,
  cup_rim_h = cup_rim_h,
  section_size = test_rabbet_corner_section_size,
  coupon_gap = test_rabbet_coupon_gap,
  body_margin_from_groove = test_rabbet_body_margin_from_groove
);
