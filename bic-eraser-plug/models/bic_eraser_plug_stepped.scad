// Stepped plug with an eraser-sized insert and a pencil-top-sized head.

use <../lib/project/bic_eraser_plug.scad>;

// ---------- Public parameters (mm) ----------
insert_diameter = 6.25;  // Measured diameter minus 0.15 mm for fit tuning.
insert_height = 12.0;    // Total height from pencil opening to top of plug.
head_diameter = 6.85;    // Previous tuned diameter plus 0.35 mm for cap fit.
head_height = 6.5;       // Measured exposed head height plus 0.5 mm.
$fn = 96;

bic_eraser_plug(
  insert_diameter = insert_diameter,
  insert_height = insert_height,
  head_diameter = head_diameter,
  head_height = head_height
);
