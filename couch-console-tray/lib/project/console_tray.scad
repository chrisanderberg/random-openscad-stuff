// lib/project/console_tray.scad
// Reusable geometry for the couch console tray.

use <util.scad>;

function tray_body_h(tray_floor_t, tray_wall_h) = tray_floor_t + tray_wall_h;
function cup_center_y(tray_d, cup_y_from_front) = -tray_d / 2 + cup_y_from_front;

module tray_variant(
  tray_w = 286,
  tray_d = 150,
  tray_corner_r = 15,
  tray_floor_t = 2.4,
  tray_wall_h = 9,
  top_wall_w = 10,
  support_lip_drop = 10,
  support_lip_w = 10,
  rear_gap_w = 28,
  rear_tongue_w = 170,
  rear_tongue_depth = 34,
  rear_tongue_t = 1.8,
  cup_spacing = 118,
  cup_y_from_front = 72,
  plug_top_d = 85,
  plug_bottom_d = 73,
  plug_h = 62,
  plug_clearance_z = 0.8,
  debug = false
) {
  body_h = tray_body_h(tray_floor_t, tray_wall_h);
  cup_y = cup_center_y(tray_d, cup_y_from_front);

  union() {
    tray_shell(
      tray_w = tray_w,
      tray_d = tray_d,
      tray_corner_r = tray_corner_r,
      body_h = body_h,
      tray_floor_t = tray_floor_t,
      top_wall_w = top_wall_w
    );

    underside_supports(
      tray_w = tray_w,
      tray_d = tray_d,
      tray_corner_r = tray_corner_r,
      support_lip_drop = support_lip_drop,
      support_lip_w = support_lip_w,
      rear_gap_w = rear_gap_w,
      rear_tongue_w = rear_tongue_w,
      rear_tongue_depth = rear_tongue_depth,
      rear_tongue_t = rear_tongue_t
    );

    if (cup_spacing > 0 && plug_top_d > 0 && plug_bottom_d > 0 && plug_h > 0) {
      for (x = [-cup_spacing / 2, cup_spacing / 2]) {
        translate([x, cup_y, -plug_clearance_z])
          cup_holder_plug(
            top_d = plug_top_d,
            bottom_d = plug_bottom_d,
            h = plug_h
          );
      }
    }

    if (debug) {
      color([1, 0, 0, 0.35])
        translate([0, cup_y, 0])
        cube([cup_spacing, 1, body_h], center = true);
    }
  }
}

module tray_outline_2d(tray_w, tray_d, tray_corner_r) {
  rounded_rect_2d([tray_w, tray_d], r = tray_corner_r);
}

module tray_pocket_2d(tray_w, tray_d, tray_corner_r, top_wall_w) {
  rounded_rect_2d(
    [tray_w - 2 * top_wall_w, tray_d - 2 * top_wall_w],
    r = max(tray_corner_r - top_wall_w, 1)
  );
}

module tray_shell(
  tray_w,
  tray_d,
  tray_corner_r,
  body_h,
  tray_floor_t,
  top_wall_w
) {
  difference() {
    linear_extrude(height = body_h)
      tray_outline_2d(tray_w, tray_d, tray_corner_r);

    translate([0, 0, tray_floor_t])
      linear_extrude(height = body_h - tray_floor_t + 0.01)
      tray_pocket_2d(tray_w, tray_d, tray_corner_r, top_wall_w);
  }
}

module underside_support_mask_2d(
  tray_w,
  tray_d,
  support_lip_w,
  rear_gap_w,
  rear_tongue_w
) {
  left_segment_w = (tray_w - rear_tongue_w - 2 * rear_gap_w) / 2;
  left_segment_x = -tray_w / 2 + left_segment_w / 2;
  right_segment_x = tray_w / 2 - left_segment_w / 2;
  side_segment_d = tray_d - 2 * support_lip_w;
  front_segment_y = -tray_d / 2 + support_lip_w / 2;
  rear_segment_y = tray_d / 2 - support_lip_w / 2;

  union() {
    translate([0, front_segment_y])
      square([tray_w, support_lip_w], center = true);

    for (x = [-tray_w / 2 + support_lip_w / 2, tray_w / 2 - support_lip_w / 2]) {
      translate([x, 0])
        square([support_lip_w, side_segment_d], center = true);
    }

    for (x = [left_segment_x, right_segment_x]) {
      translate([x, rear_segment_y])
        square([left_segment_w, support_lip_w], center = true);
    }
  }
}

module underside_support_ring_2d(
  tray_w,
  tray_d,
  tray_corner_r,
  support_lip_w,
  rear_gap_w,
  rear_tongue_w
) {
  intersection() {
    difference() {
      tray_outline_2d(tray_w, tray_d, tray_corner_r);
      tray_pocket_2d(tray_w, tray_d, tray_corner_r, support_lip_w);
    }

    underside_support_mask_2d(
      tray_w = tray_w,
      tray_d = tray_d,
      support_lip_w = support_lip_w,
      rear_gap_w = rear_gap_w,
      rear_tongue_w = rear_tongue_w
    );
  }
}

module underside_supports(
  tray_w,
  tray_d,
  tray_corner_r,
  support_lip_drop,
  support_lip_w,
  rear_gap_w,
  rear_tongue_w,
  rear_tongue_depth,
  rear_tongue_t
) {
  union() {
    // Rounded support lip following the tray perimeter where support is wanted.
    translate([0, 0, -support_lip_drop])
      linear_extrude(height = support_lip_drop)
      underside_support_ring_2d(
        tray_w = tray_w,
        tray_d = tray_d,
        tray_corner_r = tray_corner_r,
        support_lip_w = support_lip_w,
        rear_gap_w = rear_gap_w,
        rear_tongue_w = rear_tongue_w
      );

    // Thin rear tongue that reaches into the storage opening under the lid.
    translate([0, tray_d / 2 + rear_tongue_depth / 2, -rear_tongue_t / 2])
      cube([rear_tongue_w, rear_tongue_depth, rear_tongue_t], center = true);
  }
}

module cup_holder_plug(top_d, bottom_d, h) {
  translate([0, 0, -h])
    cylinder(d1 = bottom_d, d2 = top_d, h = h + 1, center = false, $fn = 96);
}

module cup_holder_pair(spacing, cup_y, top_d, bottom_d, h, plug_clearance_z = 0) {
  for (x = [-spacing / 2, spacing / 2]) {
    translate([x, cup_y, -plug_clearance_z])
      cup_holder_plug(top_d = top_d, bottom_d = bottom_d, h = h);
  }
}

module perimeter_frame_variant(
  tray_w,
  tray_d,
  tray_corner_r,
  frame_wall_w,
  tray_floor_t,
  support_lip_drop,
  support_lip_w,
  rear_gap_w,
  rear_tongue_w,
  rear_tongue_depth,
  rear_tongue_t
) {
  union() {
    linear_extrude(height = tray_floor_t)
      difference() {
        tray_outline_2d(tray_w, tray_d, tray_corner_r);
        tray_pocket_2d(tray_w, tray_d, tray_corner_r, frame_wall_w);
      }

    underside_supports(
      tray_w = tray_w,
      tray_d = tray_d,
      tray_corner_r = tray_corner_r,
      support_lip_drop = support_lip_drop,
      support_lip_w = support_lip_w,
      rear_gap_w = rear_gap_w,
      rear_tongue_w = rear_tongue_w,
      rear_tongue_depth = rear_tongue_depth,
      rear_tongue_t = rear_tongue_t
    );
  }
}

module front_edge_cup_zone_variant(
  tray_w,
  tray_d,
  tray_corner_r,
  tray_floor_t,
  tray_wall_h,
  top_wall_w,
  support_lip_drop,
  support_lip_w,
  rear_gap_w,
  rear_tongue_w,
  rear_tongue_depth,
  rear_tongue_t,
  cup_spacing,
  cup_y_from_front,
  plug_top_d,
  plug_bottom_d,
  plug_h,
  front_zone_depth
) {
  intersection() {
    tray_variant(
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
      plug_clearance_z = 0
    );

    translate([0, -tray_d / 2 + front_zone_depth / 2, -plug_h - 2])
      cube([tray_w + 4, front_zone_depth, plug_h + tray_body_h(tray_floor_t, tray_wall_h) + 4], center = true);
  }
}

module rear_tongue_test_variant(
  tray_w,
  tray_d,
  tray_corner_r,
  tray_floor_t,
  tray_wall_h,
  top_wall_w,
  support_lip_drop,
  support_lip_w,
  rear_gap_w,
  rear_tongue_w,
  rear_tongue_depth,
  rear_tongue_t,
  rear_zone_depth
) {
  intersection() {
    tray_variant(
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
      cup_spacing = 0,
      plug_top_d = 0,
      plug_bottom_d = 0,
      plug_h = 0
    );

    translate([0, tray_d / 2 + rear_tongue_depth / 2 - rear_zone_depth / 2, -support_lip_drop - 2])
      cube([tray_w + 4, rear_zone_depth, support_lip_drop + tray_body_h(tray_floor_t, tray_wall_h) + 6], center = true);
  }
}

module back_gap_fit_variant(
  tray_w,
  tray_d,
  tray_corner_r,
  tray_floor_t,
  tray_wall_h,
  top_wall_w,
  support_lip_drop,
  support_lip_w,
  rear_gap_w,
  rear_tongue_w,
  rear_tongue_depth,
  rear_tongue_t,
  section_w
) {
  intersection() {
    rear_tongue_test_variant(
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
      rear_zone_depth = rear_tongue_depth + support_lip_w + 10
    );

    translate([-tray_w / 4, tray_d / 2 + rear_tongue_depth / 2, 0])
      cube([section_w, rear_tongue_depth + support_lip_w + 14, tray_body_h(tray_floor_t, tray_wall_h) + support_lip_drop + 8], center = true);
  }
}

module front_corner_lip_coupon(
  tray_corner_r,
  coupon_size,
  tray_floor_t,
  support_lip_drop,
  support_lip_w
) {
  intersection() {
    union() {
      linear_extrude(height = tray_floor_t)
        tray_outline_2d(coupon_size, coupon_size, tray_corner_r);

      translate([0, 0, -support_lip_drop])
        linear_extrude(height = support_lip_drop)
        underside_support_ring_2d(
          tray_w = coupon_size,
          tray_d = coupon_size,
          tray_corner_r = tray_corner_r,
          support_lip_w = support_lip_w,
          rear_gap_w = 0,
          rear_tongue_w = coupon_size
        );
    }

    translate([-coupon_size / 2, -coupon_size / 2, -support_lip_drop - 1])
      cube([coupon_size / 2 + tray_corner_r, coupon_size / 2 + tray_corner_r, tray_floor_t + support_lip_drop + 2]);
  }
}
