use <../../lib/project/console_tray.scad>;
include <../../lib/project/params.scad>;

rear_tongue_t_test = rear_tongue_t;
coupon_w = rear_tongue_w / 3;

cube([coupon_w, rear_tongue_depth, rear_tongue_t_test], center = false);
