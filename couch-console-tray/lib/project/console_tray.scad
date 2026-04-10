// lib/project/console_tray.scad
// Reusable geometry for the couch console tray.

use <util.scad>;

function tray_floor_total_t(tray_floor_t, cup_rim_h) = tray_floor_t + max(cup_rim_h, 0);
function tray_body_h(tray_floor_t, tray_wall_h, cup_rim_h = 0) =
  tray_floor_total_t(tray_floor_t, cup_rim_h) + tray_wall_h;
function cup_center_y(tray_d, cup_y_from_front) = -tray_d / 2 + cup_y_from_front;
function tray_nominal_front_y(tray_d) = -tray_d / 2;
function cup_rim_relief_d(plug_top_d, cup_rim_w) = plug_top_d + 2 * cup_rim_w;
function cup_rim_relief_taper_d(relief_d, relief_h) = relief_d + 2 * max(relief_h, 0);
function tray_shell_center_y(front_extension = 0) = -front_extension / 2;
function tray_base_h(tray_floor_t, cup_rim_h = 0) = tray_floor_total_t(tray_floor_t, cup_rim_h);
function centered_rabbet_outer_inset(top_wall_w, rabbet_w) = max((top_wall_w - rabbet_w) / 2, 0);
function splice_plate_center_y(tray_d, splice_plate_y_from_front) =
  tray_nominal_front_y(tray_d) + splice_plate_y_from_front;

module cup_rim_relief_cut(relief_d, relief_h) {
  if (relief_h > 0) {
    translate([0, 0, -0.01])
      cylinder(
        d1 = cup_rim_relief_taper_d(relief_d, relief_h),
        d2 = relief_d,
        h = relief_h + 0.02,
        center = false,
        $fn = 96
      );
  }
}

module tray_variant(
  tray_w = 286,
  tray_d = 150,
  front_extension = 0,
  tray_corner_r = 15,
  tray_floor_t = 2.4,
  tray_wall_h = 9,
  top_wall_w = 10,
  glue_rabbet_h = 1.6,
  glue_rabbet_w = 3.2,
  glue_rabbet_side_clearance = 0.3,
  glue_rabbet_vertical_clearance = 0.15,
  support_lip_drop = 10,
  support_lip_w = 10,
  front_lip_forward_shift = 0,
  front_lip_back_extra = 0,
  front_lip_bottom_back_extra = 0,
  side_lip_inner_extra = 0,
  side_lip_bottom_inner_extra = 0,
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
  splice_plate_enable = false,
  splice_plate_w = 120,
  splice_plate_d = 18,
  splice_plate_t = 2,
  splice_plate_corner_r = 3,
  splice_plate_y_from_front = 40,
  splice_plate_side_clearance = 0.3,
  splice_plate_vertical_clearance = 0.2,
  rear_splice_plate_enable = false,
  rear_splice_plate_y_from_front = 168,
  plug_clearance_z = 0.8,
  debug = false
) {
  floor_total_t = tray_floor_total_t(tray_floor_t, cup_rim_h);

  union() {
    tray_body_variant(
      tray_w = tray_w,
      tray_d = tray_d,
      front_extension = front_extension,
      tray_corner_r = tray_corner_r,
      tray_floor_t = tray_floor_t,
      top_wall_w = top_wall_w,
      glue_rabbet_h = glue_rabbet_h,
      glue_rabbet_w = glue_rabbet_w,
      glue_rabbet_side_clearance = glue_rabbet_side_clearance,
      glue_rabbet_vertical_clearance = glue_rabbet_vertical_clearance,
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
      splice_plate_enable = splice_plate_enable,
      splice_plate_w = splice_plate_w,
      splice_plate_d = splice_plate_d,
      splice_plate_t = splice_plate_t,
      splice_plate_corner_r = splice_plate_corner_r,
      splice_plate_y_from_front = splice_plate_y_from_front,
      splice_plate_side_clearance = splice_plate_side_clearance,
      splice_plate_vertical_clearance = splice_plate_vertical_clearance,
      rear_splice_plate_enable = rear_splice_plate_enable,
      rear_splice_plate_y_from_front = rear_splice_plate_y_from_front,
      plug_clearance_z = plug_clearance_z,
      debug = debug
    );

    translate([0, 0, floor_total_t])
      tray_rim_variant(
        tray_w = tray_w,
        tray_d = tray_d,
        front_extension = front_extension,
        tray_corner_r = tray_corner_r,
        tray_wall_h = tray_wall_h,
        top_wall_w = top_wall_w,
        glue_rabbet_h = glue_rabbet_h,
        glue_rabbet_w = glue_rabbet_w,
        glue_rabbet_side_clearance = glue_rabbet_side_clearance,
        glue_rabbet_vertical_clearance = glue_rabbet_vertical_clearance
      );
  }
}

module underside_splice_plate_2d(splice_plate_w, splice_plate_d, splice_plate_corner_r) {
  rounded_rect_2d(
    [splice_plate_w, splice_plate_d],
    r = min(splice_plate_corner_r, min(splice_plate_w, splice_plate_d) / 2)
  );
}

module underside_splice_plate_cut(
  splice_plate_w,
  splice_plate_d,
  splice_plate_t,
  splice_plate_corner_r,
  splice_plate_side_clearance,
  splice_plate_vertical_clearance,
  pocket_center_y,
  pocket_depth_limit
) {
  safe_splice_side_clearance = max(splice_plate_side_clearance, 0);
  splice_pocket_w = max(splice_plate_w + 2 * safe_splice_side_clearance, 0);
  splice_pocket_d = max(splice_plate_d + 2 * safe_splice_side_clearance, 0);
  splice_pocket_depth = min(
    max(splice_plate_t + max(splice_plate_vertical_clearance, 0), 0),
    pocket_depth_limit
  );

  if (splice_pocket_depth > 0 && splice_pocket_w > 0 && splice_pocket_d > 0) {
    translate([0, pocket_center_y, -0.01])
      linear_extrude(height = splice_pocket_depth + 0.02)
        underside_splice_plate_2d(
          splice_plate_w = splice_pocket_w,
          splice_plate_d = splice_pocket_d,
          splice_plate_corner_r = splice_plate_corner_r + safe_splice_side_clearance
        );
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

module tray_wall_ring_2d(tray_w, tray_d, tray_corner_r, top_wall_w, front_extension = 0) {
  difference() {
    tray_outline_2d(
      tray_w = tray_w,
      tray_d = tray_d,
      tray_corner_r = tray_corner_r,
      front_extension = front_extension
    );

    tray_pocket_2d(
      tray_w = tray_w,
      tray_d = tray_d,
      tray_corner_r = tray_corner_r,
      top_wall_w = top_wall_w,
      front_extension = front_extension
    );
  }
}

module tray_glue_rabbet_ring_2d(
  tray_w,
  tray_d,
  tray_corner_r,
  front_extension = 0,
  outer_inset = 0.8,
  ring_w = 3.2
) {
  safe_outer_inset = max(outer_inset, 0);
  safe_ring_w = max(ring_w, 0);

  if (safe_ring_w > 0) {
    difference() {
      offset(delta = -safe_outer_inset)
        tray_outline_2d(
          tray_w = tray_w,
          tray_d = tray_d,
          tray_corner_r = tray_corner_r,
          front_extension = front_extension
        );

      offset(delta = -(safe_outer_inset + safe_ring_w))
        tray_outline_2d(
          tray_w = tray_w,
          tray_d = tray_d,
          tray_corner_r = tray_corner_r,
          front_extension = front_extension
        );
    }
  }
}

module tray_base_plate(
  tray_w,
  tray_d,
  front_extension,
  tray_corner_r,
  floor_total_t,
  glue_rabbet_h,
  glue_rabbet_w,
  glue_rabbet_side_clearance,
  glue_rabbet_vertical_clearance,
  top_wall_w,
  cup_spacing,
  cup_y,
  plug_top_d,
  cup_rim_w,
  cup_rim_h,
  splice_plate_enable,
  splice_plate_w,
  splice_plate_d,
  splice_plate_t,
  splice_plate_corner_r,
  splice_plate_y_from_front,
  splice_plate_side_clearance,
  splice_plate_vertical_clearance
) {
  safe_side_clearance = max(glue_rabbet_side_clearance, 0);
  safe_vertical_clearance = max(glue_rabbet_vertical_clearance, 0);
  groove_ring_w = max(min(glue_rabbet_w + 2 * safe_side_clearance, top_wall_w), 0);
  groove_outer_inset = centered_rabbet_outer_inset(top_wall_w, groove_ring_w);
  groove_depth = min(glue_rabbet_h + safe_vertical_clearance, floor_total_t);
  splice_pocket_y = splice_plate_center_y(tray_d, splice_plate_y_from_front);

  difference() {
    linear_extrude(height = floor_total_t)
      tray_outline_2d(
        tray_w = tray_w,
        tray_d = tray_d,
        tray_corner_r = tray_corner_r,
        front_extension = front_extension
      );

    if (cup_spacing > 0 && plug_top_d > 0 && cup_rim_w > 0 && cup_rim_h > 0) {
      for (x = [-cup_spacing / 2, cup_spacing / 2]) {
        // Cup-holder trim rings sit in these underside relief pockets so the tray
        // can bear on the surrounding console surface while only the plugs protrude.
        translate([x, cup_y, 0])
          cup_rim_relief_cut(
            relief_d = cup_rim_relief_d(plug_top_d, cup_rim_w),
            relief_h = cup_rim_h
          );
      }
    }

    if (groove_depth > 0 && top_wall_w > 0 && groove_ring_w > 0) {
      translate([0, 0, floor_total_t - groove_depth])
        linear_extrude(height = groove_depth + 0.02)
          tray_glue_rabbet_ring_2d(
            tray_w = tray_w,
            tray_d = tray_d,
            tray_corner_r = tray_corner_r,
            front_extension = front_extension,
            outer_inset = groove_outer_inset,
            ring_w = groove_ring_w
          );
    }

    if (splice_plate_enable) {
      // Recess a printed splice plate into the underside so the assembled tray
      // can stay flush on the console while gaining extra glue area across the split.
      underside_splice_plate_cut(
        splice_plate_w = splice_plate_w,
        splice_plate_d = splice_plate_d,
        splice_plate_t = splice_plate_t,
        splice_plate_corner_r = splice_plate_corner_r,
        splice_plate_side_clearance = splice_plate_side_clearance,
        splice_plate_vertical_clearance = splice_plate_vertical_clearance,
        pocket_center_y = splice_pocket_y,
        pocket_depth_limit = floor_total_t
      );
    }
  }
}

module tray_rim_variant(
  tray_w = 286,
  tray_d = 150,
  front_extension = 0,
  tray_corner_r = 15,
  tray_wall_h = 9,
  top_wall_w = 10,
  glue_rabbet_h = 1.6,
  glue_rabbet_w = 3.2,
  glue_rabbet_side_clearance = 0.3,
  glue_rabbet_vertical_clearance = 0.15
) {
  safe_side_clearance = max(glue_rabbet_side_clearance, 0);
  safe_vertical_clearance = max(glue_rabbet_vertical_clearance, 0);
  tongue_ring_w = max(min(glue_rabbet_w, top_wall_w - 2 * safe_side_clearance), 0);
  tongue_outer_inset = centered_rabbet_outer_inset(top_wall_w, tongue_ring_w);
  tongue_h = max(glue_rabbet_h, 0);

  if (tray_wall_h > 0 && top_wall_w > 0) {
    union() {
      linear_extrude(height = tray_wall_h)
        tray_wall_ring_2d(
          tray_w = tray_w,
          tray_d = tray_d,
          tray_corner_r = tray_corner_r,
          top_wall_w = top_wall_w,
          front_extension = front_extension
        );

      if (tongue_h > 0 && tongue_ring_w > 0) {
        translate([0, 0, -tongue_h])
          linear_extrude(height = tongue_h)
            tray_glue_rabbet_ring_2d(
              tray_w = tray_w,
              tray_d = tray_d,
              tray_corner_r = tray_corner_r,
              front_extension = front_extension,
              outer_inset = tongue_outer_inset,
              ring_w = tongue_ring_w
            );
      }
    }
  }
}

module tray_body_variant(
  tray_w = 286,
  tray_d = 150,
  front_extension = 0,
  tray_corner_r = 15,
  tray_floor_t = 2.4,
  top_wall_w = 10,
  glue_rabbet_h = 1.6,
  glue_rabbet_w = 3.2,
  glue_rabbet_side_clearance = 0.3,
  glue_rabbet_vertical_clearance = 0.15,
  support_lip_drop = 10,
  support_lip_w = 10,
  front_lip_forward_shift = 0,
  front_lip_back_extra = 0,
  front_lip_bottom_back_extra = 0,
  side_lip_inner_extra = 0,
  side_lip_bottom_inner_extra = 0,
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
  splice_plate_enable = false,
  splice_plate_w = 120,
  splice_plate_d = 18,
  splice_plate_t = 2,
  splice_plate_corner_r = 3,
  splice_plate_y_from_front = 40,
  splice_plate_side_clearance = 0.3,
  splice_plate_vertical_clearance = 0.2,
  rear_splice_plate_enable = false,
  rear_splice_plate_y_from_front = 168,
  plug_clearance_z = 0.8,
  debug = false
) {
  floor_total_t = tray_floor_total_t(tray_floor_t, cup_rim_h);
  base_h = tray_base_h(tray_floor_t, cup_rim_h);
  cup_y = cup_center_y(tray_d, cup_y_from_front);
  plug_embed_h = max(cup_rim_h + 1, 1);
  plug_cavity_embed_h = 0;
  rear_splice_pocket_y = splice_plate_center_y(tray_d, rear_splice_plate_y_from_front);

  difference() {
    union() {
      tray_base_plate(
        tray_w = tray_w,
        tray_d = tray_d,
        front_extension = front_extension,
        tray_corner_r = tray_corner_r,
        floor_total_t = floor_total_t,
        glue_rabbet_h = glue_rabbet_h,
        glue_rabbet_w = glue_rabbet_w,
        glue_rabbet_side_clearance = glue_rabbet_side_clearance,
        glue_rabbet_vertical_clearance = glue_rabbet_vertical_clearance,
        top_wall_w = top_wall_w,
        cup_spacing = cup_spacing,
        cup_y = cup_y,
        plug_top_d = plug_top_d,
        cup_rim_w = cup_rim_w,
        cup_rim_h = cup_rim_h,
        splice_plate_enable = splice_plate_enable,
        splice_plate_w = splice_plate_w,
        splice_plate_d = splice_plate_d,
        splice_plate_t = splice_plate_t,
        splice_plate_corner_r = splice_plate_corner_r,
        splice_plate_y_from_front = splice_plate_y_from_front,
        splice_plate_side_clearance = splice_plate_side_clearance,
        splice_plate_vertical_clearance = splice_plate_vertical_clearance
      );

      underside_supports(
        tray_w = tray_w,
        tray_d = tray_d,
        tray_corner_r = tray_corner_r,
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
          cube([cup_spacing, 1, base_h], center = true);
      }
    }

    if (rear_splice_plate_enable) {
      underside_splice_plate_cut(
        splice_plate_w = splice_plate_w,
        splice_plate_d = splice_plate_d,
        splice_plate_t = splice_plate_t,
        splice_plate_corner_r = splice_plate_corner_r,
        splice_plate_side_clearance = splice_plate_side_clearance,
        splice_plate_vertical_clearance = splice_plate_vertical_clearance,
        pocket_center_y = rear_splice_pocket_y,
        pocket_depth_limit = rear_tongue_t
      );
    }
  }
}

module splice_plate_variant(
  splice_plate_w = 120,
  splice_plate_d = 18,
  splice_plate_t = 2,
  splice_plate_corner_r = 3
) {
  if (splice_plate_w > 0 && splice_plate_d > 0 && splice_plate_t > 0) {
    linear_extrude(height = splice_plate_t)
      underside_splice_plate_2d(
        splice_plate_w = splice_plate_w,
        splice_plate_d = splice_plate_d,
        splice_plate_corner_r = splice_plate_corner_r
      );
  }
}

module positioned_splice_plate_variant(
  tray_d,
  splice_plate_w,
  splice_plate_d,
  splice_plate_t,
  splice_plate_corner_r,
  splice_plate_y_from_front
) {
  if (splice_plate_w > 0 && splice_plate_d > 0 && splice_plate_t > 0) {
    translate([0, splice_plate_center_y(tray_d, splice_plate_y_from_front), 0])
      splice_plate_variant(
        splice_plate_w = splice_plate_w,
        splice_plate_d = splice_plate_d,
        splice_plate_t = splice_plate_t,
        splice_plate_corner_r = splice_plate_corner_r
      );
  }
}

module underside_support_mask_2d(
  tray_w,
  tray_d,
  support_lip_w,
  front_lip_forward_shift,
  rear_gap_w,
  rear_tongue_w
) {
  // Let the side lip run all the way to the rear perimeter so the outer
  // rounded tray outline defines a flush rounded termination at the back edge.
  front_shift = max(front_lip_forward_shift, 0);
  side_segment_d = tray_d + front_shift;
  side_segment_y = -front_shift / 2;
  front_segment_y = -tray_d / 2 - front_shift + support_lip_w / 2;

  union() {
    translate([0, front_segment_y])
      square([tray_w, support_lip_w], center = true);

    for (x = [-tray_w / 2 + support_lip_w / 2, tray_w / 2 - support_lip_w / 2]) {
      translate([x, side_segment_y])
        square([support_lip_w, side_segment_d], center = true);
    }
  }
}

module underside_support_ring_2d(
  tray_w,
  tray_d,
  tray_corner_r,
  support_lip_w,
  front_lip_forward_shift,
  rear_gap_w,
  rear_tongue_w
) {
  intersection() {
    difference() {
      tray_outline_2d(
        tray_w = tray_w,
        tray_d = tray_d,
        tray_corner_r = tray_corner_r,
        front_extension = front_lip_forward_shift
      );
      tray_pocket_2d(
        tray_w = tray_w,
        tray_d = tray_d,
        tray_corner_r = tray_corner_r,
        top_wall_w = support_lip_w,
        front_extension = front_lip_forward_shift
      );
    }

    underside_support_mask_2d(
      tray_w = tray_w,
      tray_d = tray_d,
      support_lip_w = support_lip_w,
      front_lip_forward_shift = front_lip_forward_shift,
      rear_gap_w = rear_gap_w,
      rear_tongue_w = rear_tongue_w
    );
  }
}

module rounded_support_lip_volume(
  tray_w,
  tray_d,
  tray_corner_r,
  support_lip_drop,
  support_lip_w,
  front_lip_forward_shift,
  rear_gap_w,
  rear_tongue_w,
  lip_join_h
) {
  translate([0, 0, -support_lip_drop])
    linear_extrude(height = support_lip_drop + lip_join_h)
      underside_support_ring_2d(
        tray_w = tray_w,
        tray_d = tray_d,
        tray_corner_r = tray_corner_r,
        support_lip_w = support_lip_w,
        front_lip_forward_shift = front_lip_forward_shift,
        rear_gap_w = rear_gap_w,
        rear_tongue_w = rear_tongue_w
      );
}

module side_support_wedge_clip_volume(
  tray_w,
  tray_d,
  tray_corner_r,
  support_lip_drop,
  support_lip_w,
  front_lip_forward_shift,
  side_lip_inner_extra,
  lip_join_h
) {
  front_shift = max(front_lip_forward_shift, 0);
  side_extra = max(side_lip_inner_extra, 0);
  side_segment_d = tray_d + front_shift;
  side_segment_y = -front_shift / 2;
  side_clip_w = support_lip_w + side_extra;

  translate([0, 0, -support_lip_drop])
    linear_extrude(height = support_lip_drop + lip_join_h)
      intersection() {
        tray_outline_2d(
          tray_w = tray_w,
          tray_d = tray_d,
          tray_corner_r = tray_corner_r,
          front_extension = front_shift
        );

        union() {
          for (x = [
            -tray_w / 2 + side_clip_w / 2,
            tray_w / 2 - side_clip_w / 2
          ]) {
            translate([x, side_segment_y])
              square([side_clip_w, side_segment_d], center = true);
          }
        }
      };
}

module underside_supports(
  tray_w,
  tray_d,
  tray_corner_r,
  support_lip_drop,
  support_lip_w,
  front_lip_forward_shift,
  front_lip_back_extra,
  front_lip_bottom_back_extra,
  side_lip_inner_extra,
  side_lip_bottom_inner_extra,
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
    rounded_support_lip_volume(
      tray_w = tray_w,
      tray_d = tray_d,
      tray_corner_r = tray_corner_r,
      support_lip_drop = support_lip_drop,
      support_lip_w = support_lip_w,
      front_lip_forward_shift = front_lip_forward_shift,
      rear_gap_w = rear_gap_w,
      rear_tongue_w = rear_tongue_w,
      lip_join_h = lip_join_h
    );

    front_lip_shift = max(front_lip_forward_shift, 0);
    front_lip_front_y = -tray_d / 2 - front_lip_shift;
    front_lip_center_y = front_lip_front_y + support_lip_w;
    front_lip_span_w = max(tray_w - 2 * support_lip_w, 0);
    front_lip_top_extra = max(front_lip_back_extra, 0);
    front_lip_bottom_extra = min(max(front_lip_bottom_back_extra, 0), front_lip_top_extra);
    side_lip_top_extra = max(side_lip_inner_extra, 0);
    side_lip_bottom_extra = min(max(side_lip_bottom_inner_extra, 0), side_lip_top_extra);
    side_lip_depth = tray_d + front_lip_shift;
    side_lip_center_y = -front_lip_shift / 2;

    if (support_lip_drop > 0 && front_lip_span_w > 0 && front_lip_top_extra > 0) {
      // Add material only to the back face of the front lip so the outer/front
      // face stays fixed while the inner face tapers to fit the console curve.
      polyhedron(
        points = [
          [-front_lip_span_w / 2, front_lip_center_y + front_lip_bottom_extra, -support_lip_drop],
          [ front_lip_span_w / 2, front_lip_center_y + front_lip_bottom_extra, -support_lip_drop],
          [-front_lip_span_w / 2, front_lip_center_y + front_lip_top_extra, lip_join_h],
          [ front_lip_span_w / 2, front_lip_center_y + front_lip_top_extra, lip_join_h],
          [-front_lip_span_w / 2, front_lip_center_y, lip_join_h],
          [ front_lip_span_w / 2, front_lip_center_y, lip_join_h]
        ],
        faces = [
          [0, 1, 3, 2],
          [0, 2, 4],
          [1, 5, 3],
          [0, 4, 5, 1],
          [2, 3, 5, 4]
        ]
      );
    }

    if (support_lip_drop > 0 && side_lip_depth > 0 && side_lip_top_extra > 0) {
      // Keep the outside faces fixed and thicken the side lips inward near
      // the tray body with a gentler taper than the front lip.
      intersection() {
        side_support_wedge_clip_volume(
          tray_w = tray_w,
          tray_d = tray_d,
          tray_corner_r = tray_corner_r,
          support_lip_drop = support_lip_drop,
          support_lip_w = support_lip_w,
          front_lip_forward_shift = front_lip_forward_shift,
          side_lip_inner_extra = side_lip_top_extra,
          lip_join_h = lip_join_h
        );

        union() {
          polyhedron(
            points = [
              [ tray_w / 2 - support_lip_w - side_lip_bottom_extra, -side_lip_depth / 2 + side_lip_center_y, -support_lip_drop],
              [ tray_w / 2 - support_lip_w - side_lip_bottom_extra,  side_lip_depth / 2 + side_lip_center_y, -support_lip_drop],
              [ tray_w / 2 - support_lip_w - side_lip_top_extra,    -side_lip_depth / 2 + side_lip_center_y, lip_join_h],
              [ tray_w / 2 - support_lip_w - side_lip_top_extra,     side_lip_depth / 2 + side_lip_center_y, lip_join_h],
              [ tray_w / 2 - support_lip_w,                         -side_lip_depth / 2 + side_lip_center_y, lip_join_h],
              [ tray_w / 2 - support_lip_w,                          side_lip_depth / 2 + side_lip_center_y, lip_join_h]
            ],
            faces = [
              [0, 1, 3, 2],
              [0, 2, 4],
              [1, 5, 3],
              [0, 4, 5, 1],
              [2, 3, 5, 4]
            ]
          );

          polyhedron(
            points = [
              [-tray_w / 2 + support_lip_w + side_lip_bottom_extra, -side_lip_depth / 2 + side_lip_center_y, -support_lip_drop],
              [-tray_w / 2 + support_lip_w + side_lip_bottom_extra,  side_lip_depth / 2 + side_lip_center_y, -support_lip_drop],
              [-tray_w / 2 + support_lip_w + side_lip_top_extra,    -side_lip_depth / 2 + side_lip_center_y, lip_join_h],
              [-tray_w / 2 + support_lip_w + side_lip_top_extra,     side_lip_depth / 2 + side_lip_center_y, lip_join_h],
              [-tray_w / 2 + support_lip_w,                         -side_lip_depth / 2 + side_lip_center_y, lip_join_h],
              [-tray_w / 2 + support_lip_w,                          side_lip_depth / 2 + side_lip_center_y, lip_join_h]
            ],
            faces = [
              [0, 2, 3, 1],
              [0, 4, 2],
              [1, 3, 5],
              [0, 1, 5, 4],
              [2, 4, 5, 3]
            ]
          );
        }
      }
    }

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
  front_lip_forward_shift,
  front_lip_back_extra,
  front_lip_bottom_back_extra,
  side_lip_inner_extra,
  side_lip_bottom_inner_extra,
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
      front_lip_forward_shift = front_lip_forward_shift,
      front_lip_back_extra = front_lip_back_extra,
      front_lip_bottom_back_extra = front_lip_bottom_back_extra,
      side_lip_inner_extra = side_lip_inner_extra,
      side_lip_bottom_inner_extra = side_lip_bottom_inner_extra,
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
  front_lip_forward_shift,
  front_lip_back_extra,
  front_lip_bottom_back_extra,
  side_lip_inner_extra,
  side_lip_bottom_inner_extra,
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
  front_lip_forward_shift,
  front_lip_back_extra,
  front_lip_bottom_back_extra,
  side_lip_inner_extra,
  side_lip_bottom_inner_extra,
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
      front_lip_forward_shift = front_lip_forward_shift,
      front_lip_back_extra = front_lip_back_extra,
      front_lip_bottom_back_extra = front_lip_bottom_back_extra,
      side_lip_inner_extra = side_lip_inner_extra,
      side_lip_bottom_inner_extra = side_lip_bottom_inner_extra,
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
  front_lip_forward_shift,
  front_lip_back_extra,
  front_lip_bottom_back_extra,
  side_lip_inner_extra,
  side_lip_bottom_inner_extra,
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
      front_lip_forward_shift = front_lip_forward_shift,
      front_lip_back_extra = front_lip_back_extra,
      front_lip_bottom_back_extra = front_lip_bottom_back_extra,
      side_lip_inner_extra = side_lip_inner_extra,
      side_lip_bottom_inner_extra = side_lip_bottom_inner_extra,
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
  front_lip_forward_shift,
  front_lip_back_extra,
  front_lip_bottom_back_extra,
  side_lip_inner_extra,
  side_lip_bottom_inner_extra,
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

module cup_plug_side_to_side_slice_variant(
  tray_w,
  tray_d,
  front_extension,
  tray_corner_r,
  tray_floor_t,
  tray_wall_h,
  top_wall_w,
  support_lip_drop,
  support_lip_w,
  front_lip_forward_shift,
  front_lip_back_extra,
  front_lip_bottom_back_extra,
  side_lip_inner_extra,
  side_lip_bottom_inner_extra,
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
  plug_y = cup_center_y(tray_d, cup_y_from_front);
  cutout_w = tray_w + 40;
  cutout_d = tray_d + front_extension + rear_tongue_depth + 40;
  cutout_h = plug_h + body_h + support_lip_drop + 4;
  cutout_x = 0;
  cutout_z = (body_h - plug_h - support_lip_drop) / 2;
  front_cutout_y = plug_y - slice_w / 2 - cutout_d / 2;
  back_cutout_y = plug_y + slice_w / 2 + cutout_d / 2;

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
      plug_clearance_z = 0
    );

    translate([cutout_x, front_cutout_y, cutout_z])
      cube(
        [cutout_w, cutout_d, cutout_h],
        center = true
      );

    translate([cutout_x, back_cutout_y, cutout_z])
      cube(
        [cutout_w, cutout_d, cutout_h],
        center = true
      );
  }
}

module half_cup_plug_side_to_side_slice_variant(
  tray_w,
  tray_d,
  front_extension,
  tray_corner_r,
  tray_floor_t,
  tray_wall_h,
  top_wall_w,
  support_lip_drop,
  support_lip_w,
  front_lip_forward_shift,
  front_lip_back_extra,
  front_lip_bottom_back_extra,
  side_lip_inner_extra,
  side_lip_bottom_inner_extra,
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
  slice_w,
  mirror_x = false
) {
  cut_x = max(tray_w, rear_tongue_w, cup_spacing + plug_top_d) + 20;
  cut_y = tray_d + front_extension + rear_tongue_depth + 20;
  cut_z = plug_h + support_lip_drop + tray_body_h(tray_floor_t, tray_wall_h, cup_rim_h) + 20;
  x_sign = mirror_x ? -1 : 1;

  mirror([mirror_x ? 1 : 0, 0, 0])
    intersection() {
      cup_plug_side_to_side_slice_variant(
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
        slice_w = slice_w
      );

      translate([x_sign * cut_x / 4, 0, (tray_base_h(tray_floor_t, cup_rim_h) - plug_h - support_lip_drop) / 2])
        cube([cut_x / 2, cut_y, cut_z], center = true);
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
  front_lip_forward_shift = 0,
  front_lip_back_extra = 0,
  front_lip_bottom_back_extra = 0,
  side_lip_inner_extra = 0,
  side_lip_bottom_inner_extra = 0,
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
      front_lip_forward_shift = front_lip_forward_shift,
      front_lip_back_extra = front_lip_back_extra,
      front_lip_bottom_back_extra = front_lip_bottom_back_extra,
      side_lip_inner_extra = side_lip_inner_extra,
      side_lip_bottom_inner_extra = side_lip_bottom_inner_extra,
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

module front_corner_section_cutout(
  tray_w,
  tray_d,
  front_extension,
  section_size,
  section_z_min,
  section_h
) {
  section_x = tray_w / 2 - section_size / 2;
  section_y = tray_nominal_front_y(tray_d) - front_extension / 2 + section_size / 2;

  translate([section_x, section_y, section_z_min + section_h / 2])
    cube([section_size, section_size, section_h], center = true);
}

module front_corner_section_window_2d(
  tray_w,
  tray_d,
  front_extension,
  section_size
) {
  section_x = tray_w / 2 - section_size / 2;
  section_y = tray_nominal_front_y(tray_d) - front_extension / 2 + section_size / 2;

  translate([section_x, section_y])
    square([section_size, section_size], center = true);
}

module tray_body_rabbet_side_strip_2d(
  tray_w,
  tray_d,
  tray_corner_r,
  front_extension,
  top_wall_w,
  glue_rabbet_w,
  glue_rabbet_side_clearance,
  margin_from_groove
) {
  safe_side_clearance = max(glue_rabbet_side_clearance, 0);
  groove_ring_w = max(min(glue_rabbet_w + 2 * safe_side_clearance, top_wall_w), 0);
  keep_band_w = max(
    centered_rabbet_outer_inset(top_wall_w, groove_ring_w) + groove_ring_w + max(margin_from_groove, 0),
    0
  );

  section_x = tray_w / 2 - keep_band_w / 2;
  section_y = tray_nominal_front_y(tray_d) - front_extension / 2 + tray_d;

  if (keep_band_w > 0) {
    intersection() {
      tray_outline_2d(
        tray_w = tray_w,
        tray_d = tray_d,
        tray_corner_r = tray_corner_r,
        front_extension = front_extension
      );

      translate([section_x, section_y])
        square([keep_band_w, tray_d + front_extension + 2], center = true);
    }
  }
}

module top_rim_rabbet_corner_fit_variant(
  tray_w,
  tray_d,
  front_extension,
  tray_corner_r,
  tray_floor_t,
  tray_wall_h,
  top_wall_w,
  glue_rabbet_h,
  glue_rabbet_w,
  glue_rabbet_side_clearance,
  glue_rabbet_vertical_clearance,
  cup_rim_h,
  section_size,
  coupon_gap,
  body_margin_from_groove
) {
  floor_total_t = tray_floor_total_t(tray_floor_t, cup_rim_h);
  safe_side_clearance = max(glue_rabbet_side_clearance, 0);
  groove_ring_w = max(min(glue_rabbet_w + 2 * safe_side_clearance, top_wall_w), 0);
  body_strip_w = max(
    centered_rabbet_outer_inset(top_wall_w, groove_ring_w) + groove_ring_w + max(body_margin_from_groove, 0),
    0
  );
  strip_length = section_size;
  body_total_h = floor_total_t;
  rim_total_h = tray_wall_h + max(glue_rabbet_h, 0);
  front_edge_y = tray_nominal_front_y(tray_d) - front_extension;
  section_center_y = front_edge_y + strip_length / 2;
  body_source_center_x = tray_w / 2 - body_strip_w / 2;
  rim_source_center_x = tray_w / 2 - body_strip_w / 2;
  body_target_center_x = -(coupon_gap + body_strip_w) / 2;
  rim_target_center_x = (coupon_gap + body_strip_w) / 2;

  if (body_strip_w > 0) {
    translate([body_target_center_x, 0, 0])
      intersection() {
        translate([-body_source_center_x, -section_center_y, floor_total_t])
          mirror([0, 0, 1])
            tray_base_plate(
              tray_w = tray_w,
              tray_d = tray_d,
              front_extension = front_extension,
              tray_corner_r = tray_corner_r,
              floor_total_t = floor_total_t,
              glue_rabbet_h = glue_rabbet_h,
              glue_rabbet_w = glue_rabbet_w,
              glue_rabbet_side_clearance = glue_rabbet_side_clearance,
              glue_rabbet_vertical_clearance = glue_rabbet_vertical_clearance,
              top_wall_w = top_wall_w,
              cup_spacing = 0,
              cup_y = 0,
              plug_top_d = 0,
              cup_rim_w = 0,
              cup_rim_h = 0,
              splice_plate_enable = false,
              splice_plate_w = 0,
              splice_plate_d = 0,
              splice_plate_t = 0,
              splice_plate_corner_r = 0,
              splice_plate_y_from_front = 0,
              splice_plate_side_clearance = 0,
              splice_plate_vertical_clearance = 0
            );

        translate([0, 0, body_total_h / 2])
          cube([body_strip_w, strip_length, body_total_h + 0.02], center = true);
      }
  }

  translate([rim_target_center_x, 0, 0])
    intersection() {
      translate([-rim_source_center_x, -section_center_y, tray_wall_h])
        mirror([0, 0, 1])
          tray_rim_variant(
            tray_w = tray_w,
            tray_d = tray_d,
            front_extension = front_extension,
            tray_corner_r = tray_corner_r,
            tray_wall_h = tray_wall_h,
            top_wall_w = top_wall_w,
            glue_rabbet_h = glue_rabbet_h,
            glue_rabbet_w = glue_rabbet_w,
            glue_rabbet_side_clearance = glue_rabbet_side_clearance,
            glue_rabbet_vertical_clearance = glue_rabbet_vertical_clearance
          );

      translate([0, 0, rim_total_h / 2])
        cube([body_strip_w, strip_length, rim_total_h + 0.02], center = true);
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
