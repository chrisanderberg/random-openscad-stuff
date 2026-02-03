// template.scad
// Starter model wrapper.
//
// How to use:
// - Copy this file to a new name (e.g., bracket.scad).
// - Edit the parameters and the main() module.
// - Keep reusable helpers in a local lib/ folder if needed.

// ---------- Public parameters (mm) ----------
debug = false;

part_w = 40;
part_h = 20;
part_t = 4;

hole_d = 3.2; // e.g., clearance for M3.
$fn = 64; // Surface quality.

// ---------- Model ----------
module main() {
  difference() {
    // Base plate.
    cube([part_w, part_h, part_t], center = true);

    // Through hole at center.
    cylinder(d = hole_d, h = part_t + 2, center = true);
  }

  if (debug) {
    // Highlight the nominal hole cylinder (visual check).
    #cylinder(d = hole_d, h = part_t + 2, center = true);
  }
}

main();
