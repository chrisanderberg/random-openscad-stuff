use <../../lib/project/console_tray.scad>;
include <../../lib/project/params.scad>;

coupon_size = 64;
row_pitch = coupon_size + 14;

for (i = [0 : len(test_lip_drop_values) - 1]) {
  translate([i * row_pitch, 0, 0])
    front_corner_lip_coupon(
      tray_corner_r = tray_corner_r,
      coupon_size = coupon_size,
      tray_floor_t = tray_floor_t,
      support_lip_drop = test_lip_drop_values[i],
      support_lip_w = support_lip_w
    );
}
