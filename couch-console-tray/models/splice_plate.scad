// models/splice_plate.scad
// Flat printed splice plate for reinforcing the joined half trays from below.

use <../lib/project/console_tray.scad>;
include <../lib/project/params.scad>;

// ---------- Public parameters (mm) ----------
// Parameters default to the shared tray splice-plate values.

module main() {
  splice_plate_variant(
    splice_plate_w = splice_plate_w,
    splice_plate_d = splice_plate_d,
    splice_plate_t = splice_plate_t,
    splice_plate_corner_r = splice_plate_corner_r
  );
}

main();
