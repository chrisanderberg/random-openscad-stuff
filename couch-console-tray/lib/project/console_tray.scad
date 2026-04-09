// lib/project/console_tray.scad
// Reusable geometry for the couch console tray.

use <util.scad>;

function tray_floor_total_t(tray_floor_t, cup_rim_h) = tray_floor_t + max(cup_rim_h, 0);
function tray_body_h(tray_floor_t, tray_wall_h, cup_rim_h = 0) =
  tray_floor_total_t(tray_floor_t, cup_rim_h) + tray_wall_h;
function cup_center_y(tray_d, cup_y_from_front) = -tray_d / 2 + cup_y_from_front;
function cup_rim_relief_d(plug_top_d, cup_rim_w) = plug_top_d + 2 * cup_rim_w;
function tray_shell_center_y(front_extension = 0) = -front_extension / 2;

module tray_variant(
  tray_w = 286,
  tray_d = 150,
  front_extension = 0,
  tray_corner_r = 15,
  tray_floor_t = 2.4,
  tray_wall_h = 9,
  top_wall_w = 10,
  support_lip_drop = 10,
  support_lip_w = 10,
  rear_gap_w = 28,
  rear_tongue_w = 170,
  rear_tongue_depth = 34,
  rear_tongue_t = 3.6,
  cup_spacing = 118,
  cup_y_from_front = 72,
  plug_top_d = 85,
  plug_bottom_d = 73,
  plug_h = 62,
  plug_shell_t = 0,
  cup_rim_w = 0,
  cup_rim_h = 0,
  plug_clearance_z = 0.8,
  debug = false
) {
  floor_total_t = tray_floor_total_t(tray_floor_t, cup_rim_h);
  body_h = tray_body_h(tray_floor_t, tray_wall_h, cup_rim_h);
  cup_y = cup_center_y(tray_d, cup_y_from_front);
  plug_embed_h = max(cup_rim_h + 1, 1);
  plug_cavity_embed_h = 0;

  union() {
    tray_shell(
      tray_w = tray_w,
      tray_d = tray_d,
      front_extension = front_extension,
      tray_corner_r = tray_corner_r,
      body_h = body_h,
      floor_total_t = floor_total_t,
      top_wall_w = top_wall_w,
      cup_spacing = cup_spacing,
      cup_y = cup_y,
      plug_top_d = plug_top_d,
      cup_rim_w = cup_rim_w,
      cup_rim_h = cup_rim_h
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
      hollow_cup_holder_pair(
        spacing = cup_spacing,
        cup_y = cup_y,
        top_d = plug_top_d,
        bottom_d = plug_bottom_d,
        h = plug_h,
        shell_t = plug_shell_t,
        plug_clearance_z = plug_clearance_z,
        embed_h = plug_embed_h,
        cavity_embed_h = plug_cavity_embed_h
      );
    }

    if (debug) {
      color([1, 0, 0, 0.35])
        translate([0, cup_y, 0])
        cube([cup_spacing, 1, body_h], center = true);
    }
  }
}

module tray_outline_2d(tray_w, tray_d, tray_corner_r, front_extension = 0) {
  translate([0, tray_shell_center_y(front_extension)])
    rounded_rect_2d([tray_w, tray_d + front_extension], r = tray_corner_r);
}

module tray_pocket_2d(tray_w, tray_d, tray_corner_r, top_wall_w, front_extension = 0) {
  translate([0, tray_shell_center_y(front_extension)])
    rounded_rect_2d(
      [tray_w - 2 * top_wall_w, tray_d - 2 * top_wall_w + front_extension],
      r = max(tray_corner_r - top_wall_w, 1)
    );
}

module rear_tongue_outline_2d(rear_tongue_w, rear_tongue_depth, rear_corner_r) {
  rr = min(rear_corner_r, min(rear_tongue_w / 2, rear_tongue_depth));

  union() {
    translate([0, -rr / 2])
      square([rear_tongue_w, rear_tongue_depth - rr], center = true);

    if (rear_tongue_w > 2 * rr) {
      translate([0, rear_tongue_depth / 2 - rr / 2])
        square([rear_tongue_w - 2 * rr, rr], center = true);
    }

    for (x = [-rear_tongue_w / 2 + rr, rear_tongue_w / 2 - rr]) {
      translate([x, rear_tongue_depth / 2 - rr])
        circle(r = rr, $fn = 48);
    }
  }
}

module tray_shell(
  tray_w,
  tray_d,
  front_extension,
  tray_corner_r,
  body_h,
  floor_total_t,
  top_wall_w,
  cup_spacing,
  cup_y,
  plug_top_d,
  cup_rim_w,
  cup_rim_h
) {
  difference() {
    linear_extrude(height = body_h)
      tray_outline_2d(
        tray_w = tray_w,
        tray_d = tray_d,
        tray_corner_r = tray_corner_r,
        front_extension = front_extension
      );

    translate([0, 0, floor_total_t])
      linear_extrude(height = body_h - floor_total_t + 0.01)
      tray_pocket_2d(
        tray_w = tray_w,
        tray_d = tray_d,
        tray_corner_r = tray_corner_r,
        top_wall_w = top_wall_w,
        front_extension = front_extension
      );

    if (cup_spacing > 0 && plug_top_d > 0 && cup_rim_w > 0 && cup_rim_h > 0) {
      for (x = [-cup_spacing / 2, cup_spacing / 2]) {
        // Cup-holder trim rings sit in these underside relief pockets so the tray
        // can bear on the surrounding console surface while only the plugs protrude.
        translate([x, cup_y, -0.01])
          cylinder(
            d = cup_rim_relief_d(plug_top_d, cup_rim_w),
            h = cup_rim_h + 0.02,
            center = false,
            $fn = 96
          );
      }
    }
  }
}

module underside_support_mask_2d(
  tray_w,
  tray_d,
  support_lip_w,
  rear_gap_w,
  rear_tongue_w
) {
  side_segment_d = tray_d - 2 * support_lip_w;
  front_segment_y = -tray_d / 2 + support_lip_w / 2;

  union() {
    translate([0, front_segment_y])
      square([tray_w, support_lip_w], center = true);

    for (x = [-tray_w / 2 + support_lip_w / 2, tray_w / 2 - support_lip_w / 2]) {
      translate([x, 0])
        square([support_lip_w, side_segment_d], center = true);
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
  lip_join_h = 0.6;
  rear_join_depth = 6;
  rear_join_height = 0.6;

  union() {
    // Rounded support lip following the tray perimeter where support is wanted.
    translate([0, 0, -support_lip_drop])
      linear_extrude(height = support_lip_drop + lip_join_h)
      underside_support_ring_2d(
        tray_w = tray_w,
        tray_d = tray_d,
        tray_corner_r = tray_corner_r,
        support_lip_w = support_lip_w,
        rear_gap_w = rear_gap_w,
        rear_tongue_w = rear_tongue_w
      );

    // Thin rear tongue that reaches into the storage opening under the lid.
    // The tray underside is z=0, so the tongue must also start at z=0 and
    // extend upward into the tray body rather than hanging below it.
    translate([
      0,
      tray_d / 2 + rear_tongue_depth / 2 - rear_join_depth / 2,
      0
    ])
      linear_extrude(height = rear_tongue_t)
        rear_tongue_outline_2d(
          rear_tongue_w = rear_tongue_w,
          rear_tongue_depth = rear_tongue_depth + rear_join_depth,
          rear_corner_r = tray_corner_r
        );

    // Add a small hidden rib inside the tray body to create a real volumetric
    // union without leaving the tongue proud of the underside.
    translate([
      -rear_tongue_w / 2,
      tray_d / 2 - rear_join_depth,
      0
    ])
      cube([rear_tongue_w, rear_join_depth, rear_join_height], center = false);
  }
}

module cup_holder_plug(top_d, bottom_d, h, embed_h = 0) {
  translate([0, 0, -h])
    cylinder(d1 = bottom_d, d2 = top_d, h = h + embed_h, center = false, $fn = 96);
}

module cup_holder_pair(spacing, cup_y, top_d, bottom_d, h, plug_clearance_z = 0, embed_h = 0) {
  for (x = [-spacing / 2, spacing / 2]) {
    translate([x, cup_y, -plug_clearance_z])
      cup_holder_plug(top_d = top_d, bottom_d = bottom_d, h = h, embed_h = embed_h);
  }
}

module hollow_cup_holder_pair(
  spacing,
  cup_y,
  top_d,
  bottom_d,
  h,
  shell_t = 0,
  plug_clearance_z = 0,
  embed_h = 0,
  cavity_embed_h = -1
) {
  inner_top_d = max(top_d - 2 * shell_t, 0);
  inner_bottom_d = max(bottom_d - 2 * shell_t, 0);
  cavity_h = cavity_embed_h < 0 ? embed_h : cavity_embed_h;

  for (x = [-spacing / 2, spacing / 2]) {
    translate([x, cup_y, -plug_clearance_z])
      difference() {
        cup_holder_plug(top_d = top_d, bottom_d = bottom_d, h = h, embed_h = embed_h);

        if (shell_t > 0 && inner_top_d > 0 && inner_bottom_d > 0 && h > 0) {
          // Start the cavity from the plug bottom so the plug remains a shell.
          translate([0, 0, -0.01])
            cup_holder_plug(
              top_d = inner_top_d,
              bottom_d = inner_bottom_d,
              h = h,
              embed_h = cavity_h + 0.02
            );
        }
      }
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
  cup_rim_w,
  cup_rim_h,
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
      cup_rim_w = cup_rim_w,
      cup_rim_h = cup_rim_h,
      plug_clearance_z = 0
    );

    translate([0, -tray_d / 2 + front_zone_depth / 2, -plug_h - 2])
      cube([tray_w + 4, front_zone_depth, plug_h + tray_body_h(tray_floor_t, tray_wall_h, cup_rim_h) + 4], center = true);
  }
}

module rear_tongue_test_variant(
  tray_w,
  tray_d,
  front_extension,
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
      front_extension = front_extension,
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
  front_extension,
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
      front_extension = front_extension,
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

module cup_plug_front_to_back_slice_variant(
  tray_w,
  tray_d,
  front_extension,
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
  plug_shell_t,
  cup_rim_w,
  cup_rim_h,
  slice_w
) {
  body_h = tray_body_h(tray_floor_t, tray_wall_h, cup_rim_h);
  plug_x = cup_spacing / 2;
  cutout_w = tray_w;
  cutout_d = tray_d + front_extension + rear_tongue_depth + 40;
  cutout_h = plug_h + body_h + support_lip_drop + 4;
  cutout_y = (-front_extension + rear_tongue_depth) / 2;
  cutout_z = (body_h - plug_h - support_lip_drop) / 2;
  left_cutout_x = plug_x - slice_w / 2 - cutout_w / 2;
  right_cutout_x = plug_x + slice_w / 2 + cutout_w / 2;

  difference() {
    tray_variant(
      tray_w = tray_w,
      tray_d = tray_d,
      front_extension = front_extension,
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
      plug_shell_t = plug_shell_t,
      cup_rim_w = cup_rim_w,
      cup_rim_h = cup_rim_h,
      plug_clearance_z = 0
    );

    translate([left_cutout_x, cutout_y, cutout_z])
      cube(
        [cutout_w, cutout_d, cutout_h],
        center = true
      );

    translate([right_cutout_x, cutout_y, cutout_z])
      cube(
        [cutout_w, cutout_d, cutout_h],
        center = true
      );
  }
}

module front_u_wrap_lip_fit_variant(
  tray_w,
  tray_d,
  tray_corner_r,
  support_lip_drop,
  support_lip_w,
  wrap_depth
) {
  front_zone_y = -tray_d / 2 + wrap_depth / 2;

  translate([0, 0, -support_lip_drop])
    linear_extrude(height = support_lip_drop)
    intersection() {
      underside_support_ring_2d(
        tray_w = tray_w,
        tray_d = tray_d,
        tray_corner_r = tray_corner_r,
        support_lip_w = support_lip_w,
        rear_gap_w = 0,
        rear_tongue_w = 0
      );

      translate([0, front_zone_y])
        square([tray_w + 2, wrap_depth], center = true);
    }
}

module perimeter_lip_fit_variant(
  tray_w,
  tray_d,
  tray_corner_r,
  support_lip_drop,
  support_lip_w,
  rear_gap_w,
  rear_tongue_w
) {
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
}

module half_perimeter_lip_fit_variant(
  tray_w,
  tray_d,
  tray_corner_r,
  support_lip_drop,
  support_lip_w,
  rear_gap_w,
  rear_tongue_w,
  mirror_x = false
) {
  x_sign = mirror_x ? -1 : 1;

  mirror([mirror_x ? 1 : 0, 0, 0])
    intersection() {
      perimeter_lip_fit_variant(
        tray_w = tray_w,
        tray_d = tray_d,
        tray_corner_r = tray_corner_r,
        support_lip_drop = support_lip_drop,
        support_lip_w = support_lip_w,
        rear_gap_w = rear_gap_w,
        rear_tongue_w = rear_tongue_w
      );

      translate([x_sign * tray_w / 4, 0, 0])
        cube([tray_w / 2 + 2, tray_d + 4, support_lip_drop + 4], center = true);
    }
}

module front_corner_wrap_fit_variant(
  tray_w,
  tray_d,
  tray_corner_r,
  tray_floor_t,
  tray_wall_h,
  top_wall_w,
  support_lip_drop,
  support_lip_w,
  section_size
) {
  body_h = tray_body_h(tray_floor_t, tray_wall_h);
  section_x = tray_w / 2 - section_size / 2;
  section_y = -tray_d / 2 + section_size / 2;

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
      rear_gap_w = 0,
      rear_tongue_w = 0,
      rear_tongue_depth = 0,
      rear_tongue_t = 0,
      cup_spacing = 0,
      plug_top_d = 0,
      plug_bottom_d = 0,
      plug_h = 0
    );

    translate([section_x, section_y, -support_lip_drop - 1])
      cube(
        [section_size, section_size, body_h + support_lip_drop + 2],
        center = true
      );
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
