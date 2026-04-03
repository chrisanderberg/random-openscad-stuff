// models/lid_hole_jump_guard.scad
// Default printable guard for a rounded-rectangle aquarium lid opening.

use <../lib/project/lid_hole_guard.scad>;

// ---------- Public parameters (mm) ----------
debug = false;

// Measured from the lid opening with calipers.
opening_w = 50;
opening_h = 35;
opening_corner_r = 4.5;
lip_corner_r = 6.5;

fit_clearance = 0.35;
top_flange_margin = 3;
top_flange_corner_r = 9;
top_thickness = 2.4;
lip_depth = 6;
lip_wall = 3;

feed_hole_d = 6;

$fn = 72;

// ---------- Model ----------
rotate([180, 0, 0])
  lid_hole_guard(
    opening_w = opening_w,
    opening_h = opening_h,
    opening_corner_r = opening_corner_r,
    lip_corner_r = lip_corner_r,
    fit_clearance = fit_clearance,
    top_flange_margin = top_flange_margin,
    top_flange_corner_r = top_flange_corner_r,
    top_thickness = top_thickness,
    lip_depth = lip_depth,
    lip_wall = lip_wall,
    feed_hole_d = feed_hole_d,
    debug = debug
  );
