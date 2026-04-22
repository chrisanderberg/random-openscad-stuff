// Simple cylindrical plug for a Bic mechanical pencil eraser opening.

use <../lib/project/bic_eraser_plug.scad>;

// ---------- Public parameters (mm) ----------
insert_diameter = 6.25;  // Measured diameter minus 0.15 mm for fit tuning.
insert_height = 12.0;    // Total height using the measured insert plus head heights.
$fn = 96;

bic_eraser_plug(
  insert_diameter = insert_diameter,
  insert_height = insert_height
);
