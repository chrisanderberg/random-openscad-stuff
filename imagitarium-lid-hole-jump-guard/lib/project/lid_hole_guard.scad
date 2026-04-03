// lib/project/lid_hole_guard.scad
// Aquarium lid opening guard with a top flange and a locating lip underneath.

use <util.scad>;

function safe_corner_radius(w, h, r) = clamp(r, 0.01, min(w, h) / 2 - 0.01);

module rounded_rect_2d(w, h, r) {
  radius = safe_corner_radius(w, h, r);

  hull() {
    for (x = [-1, 1], y = [-1, 1]) {
      translate([x * (w / 2 - radius), y * (h / 2 - radius)])
        circle(r = radius);
    }
  }
}

module rounded_rect_prism(w, h, r, z0, z1) {
  height = z1 - z0;

  translate([0, 0, z0])
    linear_extrude(height = height)
      rounded_rect_2d(w = w, h = h, r = r);
}

module lid_hole_guard(
  opening_w = 50,
  opening_h = 35,
  opening_corner_r = 4.5,
  lip_corner_r = 6.5,
  fit_clearance = 0.35,
  top_flange_margin = 3,
  top_flange_corner_r = 9,
  top_thickness = 2.4,
  lip_depth = 6,
  lip_wall = 3,
  feed_hole_d = 6,
  debug = false
) {
  lip_w = opening_w - 2 * fit_clearance;
  lip_h = opening_h - 2 * fit_clearance;
  lip_r = safe_corner_radius(lip_w, lip_h, lip_corner_r - fit_clearance);

  flange_w = opening_w + 2 * top_flange_margin;
  flange_h = opening_h + 2 * top_flange_margin;
  flange_r = safe_corner_radius(flange_w, flange_h, top_flange_corner_r);

  lip_inner_w = max(lip_w - 2 * lip_wall, 6);
  lip_inner_h = max(lip_h - 2 * lip_wall, 6);
  lip_inner_r = safe_corner_radius(lip_inner_w, lip_inner_h, lip_r - lip_wall);

  union() {
    difference() {
      union() {
        rounded_rect_prism(
          w = flange_w,
          h = flange_h,
          r = flange_r,
          z0 = 0,
          z1 = top_thickness
        );

        difference() {
          rounded_rect_prism(
            w = lip_w,
            h = lip_h,
            r = lip_r,
            z0 = -lip_depth,
            z1 = 0
          );

          rounded_rect_prism(
            w = lip_inner_w,
            h = lip_inner_h,
            r = lip_inner_r,
            z0 = -lip_depth - 0.1,
            z1 = 0.1
          );
        }
      }

      if (feed_hole_d > 0) {
        translate([0, 0, -0.1])
          cylinder(d = feed_hole_d, h = top_thickness + 0.2);
      }
    }

    if (debug) {
      color([1, 0, 0, 0.35])
        rounded_rect_prism(
          w = opening_w,
          h = opening_h,
          r = opening_corner_r,
          z0 = -0.2,
          z1 = 0.2
        );

      color([0, 0, 1, 0.35])
        rounded_rect_prism(
          w = lip_w,
          h = lip_h,
          r = lip_r,
          z0 = -lip_depth,
          z1 = 0
        );
    }
  }
}
