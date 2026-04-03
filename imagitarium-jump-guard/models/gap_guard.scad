// models/gap_guard.scad
// Thin wrapper for the rimless aquarium rear gap guard.
// Reusable profile and 3D module live in lib/project/gap_guard.scad.

use <../lib/project/gap_guard.scad>;

// ---------- Public parameters (mm, per spec) ----------
guard_len = 210.0;
gap_depth = 35.0;
tongue_margin = 2.0;
wall_t = 1.6;
glass_t = 4.0;
clip_clearance = 0.0;
clip_h = 15.0;
lid_t = 3.0;
lid_top_below_rim = 1.0;
lid_clearance = 0.5;
chamfer = 0;   // no chamfer; profile uses square()/rectangular extrusion so $fn has no effect
// $fn = 64;
debug = false;

// ---------- Model ----------
gap_guard(
  guard_len = guard_len,
  gap_depth = gap_depth,
  tongue_margin = tongue_margin,
  wall_t = wall_t,
  glass_t = glass_t,
  clip_clearance = clip_clearance,
  clip_h = clip_h,
  lid_t = lid_t,
  lid_top_below_rim = lid_top_below_rim,
  lid_clearance = lid_clearance,
  chamfer = chamfer,
  debug = debug
);
