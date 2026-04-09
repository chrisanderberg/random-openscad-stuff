use <../../lib/project/console_tray.scad>;
include <../../lib/project/params.scad>;

coupon_size = 64;
support_lip_drop_test = support_lip_drop;

front_corner_lip_coupon(
  tray_corner_r = tray_corner_r,
  coupon_size = coupon_size,
  tray_floor_t = tray_floor_t,
  support_lip_drop = support_lip_drop_test,
  support_lip_w = support_lip_w
);
