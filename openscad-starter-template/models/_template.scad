// models/_template.scad
// Starter model wrapper.
//
// How to use:
// - Copy this file to a new name (e.g., bracket.scad).
// - Edit the parameters and the `main()` module.
// - Keep reusable helpers in lib/project/.

use <../lib/project/util.scad>;

// ---------- Public parameters (mm) ----------
debug = false;

part_w = 40;
part_h = 20;
part_t = 4;

hole_d = 3.2; // e.g., clearance for M3
$fn = 64; // surface quality

// ---------- Model ----------
module main() {
  difference() {
    // Base plate
    cube([part_w, part_h, part_t], center = true);

    // Through hole at center
    through_hole(d = hole_d, h = part_t + 2, center = true);
  }

  if (debug) {
    // Show axes at origin
    debug_axes(len = 25, t = 0.8);

    // Highlight the nominal hole cylinder (visual check)
    #through_hole(d = hole_d, h = part_t + 2, center = true);
  }
}

main();
