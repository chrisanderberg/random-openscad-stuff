// lib/project/util.scad
// Minimal general-purpose helpers for OpenSCAD projects.
// Keep this small to avoid conflicts with external libraries.

// Clamp helper: returns x limited to [lo, hi].
function clamp(x, lo, hi) = min(max(x, lo), hi);

module debug_axes(len = 20, t = 0.8) {
  // X (red), Y (green), Z (blue), starting at origin extending +axis.
  color([1, 0, 0]) cube([len, t, t], center = false);
  color([0, 1, 0]) cube([t, len, t], center = false);
  color([0, 0, 1]) cube([t, t, len], center = false);
}

module through_hole(d, h, center = true) {
  cylinder(d = d, h = h, center = center);
}

// Subtractive union: through hole + counterbore near the "top" face.
// Intended usage: difference() { solid(); counterbore_hole(...); }
module counterbore_hole(through_d, bore_d, bore_h, h, center = true) {
  union() {
    cylinder(d = through_d, h = h, center = center);

    // Place counterbore at the positive-Z face if centered, else at top of part.
    translate([0, 0, center ? (h / 2 - bore_h / 2) : (h - bore_h)])
      cylinder(d = bore_d, h = bore_h, center = true);
  }
}

// Subtractive union: through hole + conical countersink near the "top" face.
module countersink_hole(through_d, sink_d, sink_h, h, center = true) {
  union() {
    cylinder(d = through_d, h = h, center = center);

    translate([0, 0, center ? (h / 2 - sink_h / 2) : (h - sink_h)])
      cylinder(d1 = sink_d, d2 = through_d, h = sink_h, center = true);
  }
}
