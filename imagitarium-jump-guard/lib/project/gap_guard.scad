// lib/project/gap_guard.scad
// Gap guard profile and 3D module for rimless aquarium rear gap.
// Origin (0,0): top edge of tank glass at inner back corner; +X into tank, -Y down.
// Profile is X-Y; extrusion is along +Z.

// ---------- 2D helpers (clip channel and tongue bar; used by profile and debug) ----------
module clip_channel_2d(channel_width, wall_t, clip_h) {
  union() {
    translate([-(channel_width + wall_t), -clip_h]) square([wall_t, clip_h]);
    translate([0, -clip_h]) square([wall_t, clip_h]);
    translate([-(channel_width + wall_t), -wall_t])
      square([channel_width + 2 * wall_t, wall_t]);
  }
}

module tongue_bar_2d(wall_t, tongue_top, tongue_depth_val) {
  translate([wall_t, tongue_top - wall_t]) square([tongue_depth_val, wall_t]);
}

// ---------- Derived values (single source of truth) ----------
// Returns [channel_width, tongue_depth_val, lid_bottom_below_rim, tongue_top, tongue_bottom].
// channel_width: clip channel inner width (glass_t + clip_clearance).
// tongue_depth_val: depth of tongue bar into gap (gap_depth - tongue_margin).
// lid_bottom_below_rim: lid bottom Y position below rim (lid_top_below_rim + lid_t).
// tongue_top: Y coordinate of top of tongue bar, below rim (negative).
// tongue_bottom: Y coordinate of bottom of tongue bar (tongue_top - wall_t).
function gap_guard_derived(glass_t, clip_clearance, gap_depth, tongue_margin, lid_top_below_rim, lid_t, lid_clearance, wall_t) = let(
  channel_width = glass_t + clip_clearance,
  tongue_depth_val = gap_depth - tongue_margin,
  lid_bottom_below_rim = lid_top_below_rim + lid_t,
  tongue_top = -(lid_bottom_below_rim + lid_clearance),
  tongue_bottom = tongue_top - wall_t
) [channel_width, tongue_depth_val, lid_bottom_below_rim, tongue_top, tongue_bottom];

// ---------- Module: 2D profile (no guard_len) ----------
// chamfer: corner relief size (mm); 0 = sharp edges; >0 bevels outer profile edges via offset.
module gap_guard_profile_2d(
  gap_depth,
  tongue_margin,
  wall_t,
  glass_t,
  clip_clearance,
  clip_h,
  lid_t,
  lid_top_below_rim,
  lid_clearance,
  chamfer = 0
) {
  d = gap_guard_derived(glass_t, clip_clearance, gap_depth, tongue_margin, lid_top_below_rim, lid_t, lid_clearance, wall_t);
  channel_width = d[0];
  tongue_depth_val = d[1];
  tongue_top = d[3];

  module profile_core() {
    union() {
      clip_channel_2d(channel_width, wall_t, clip_h);
      tongue_bar_2d(wall_t, tongue_top, tongue_depth_val);
    }
  }

  if (chamfer > 0) {
    // Bevel outer edges: shrink then expand with 45° chamfer
    offset(delta = -chamfer)
      offset(delta = chamfer, chamfer = true)
        profile_core();
  } else {
    profile_core();
  }
}

// ---------- Module: 3D guard (linear_extrude along Z) ----------
// chamfer: passed to profile; bevels outer 2D edges when > 0.
module gap_guard(
  guard_len,
  gap_depth,
  tongue_margin,
  wall_t,
  glass_t,
  clip_clearance,
  clip_h,
  lid_t,
  lid_top_below_rim,
  lid_clearance,
  chamfer = 0,
  debug = false
) {
  d = gap_guard_derived(glass_t, clip_clearance, gap_depth, tongue_margin, lid_top_below_rim, lid_t, lid_clearance, wall_t);
  channel_width = d[0];
  tongue_depth_val = d[1];
  lid_bottom_below_rim = d[2];
  tongue_top = d[3];
  tongue_bottom = d[4];

  linear_extrude(height = guard_len)
    gap_guard_profile_2d(
      gap_depth = gap_depth,
      tongue_margin = tongue_margin,
      wall_t = wall_t,
      glass_t = glass_t,
      clip_clearance = clip_clearance,
      clip_h = clip_h,
      lid_t = lid_t,
      lid_top_below_rim = lid_top_below_rim,
      lid_clearance = lid_clearance,
      chamfer = chamfer
    );

  if (debug) {
    x_min = -(channel_width + wall_t);
    x_span = (wall_t + tongue_depth_val) - x_min;
    // Reference plane: y = 0 (rim top)
    translate([x_min, -0.1, 0]) cube([x_span, 0.2, guard_len]);
    // Reference plane: y = -lid_bottom_below_rim (lid bottom nominal)
    translate([x_min, -lid_bottom_below_rim - 0.1, 0]) cube([x_span, 0.2, guard_len]);
    // Reference plane: x = wall_t + tongue_depth_val (nominal coverage)
    y_plane_min = tongue_bottom;
    y_plane_span = 0 - y_plane_min;
    translate([wall_t + tongue_depth_val - 0.1, y_plane_min, 0])
      cube([0.2, y_plane_span, guard_len]);

    // Highlight clip channel and tongue (reuse 2D helpers)
    # linear_extrude(height = guard_len) {
      clip_channel_2d(channel_width, wall_t, clip_h);
      tongue_bar_2d(wall_t, tongue_top, tongue_depth_val);
    }
  }
}
