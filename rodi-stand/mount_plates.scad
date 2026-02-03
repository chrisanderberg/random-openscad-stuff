// RO/DI Mount Plates
// Designed to be printed on their side and arranged diagonally on a 256x256x256 mm build plate
// These plates will be super glued to the mounting surface on the stand

// ---------- Public parameters (mm) ----------
// Mount plate dimensions (matching stand mounting surface).
mount_width = 100;
mount_thickness = 10; // Thickness in mm - matches stand.scad.

screw_hole_diameter = 2;
screw_hole_vertical_spacing = 250;
screw_hole_top_spacing = 20;

// Plate lengths.
plate_1_length = 325; // First plate length in mm.
plate_2_length = 100; // Second plate length in mm.

// ---------- Resolution ----------
$fa = 1;
$fs = 1;

module screw_hole(hole_diameter) {
  translate([0, -1, 0])
  rotate([-90, 0, 0])
  cylinder(mount_thickness + 2, hole_diameter, hole_diameter);
}

module screw_hole_test() {
  difference() {
    cube([120, mount_thickness, 50]);
    translate([20, 0, 25])
      screw_hole(1.6);
    translate([40, 0, 25])
      screw_hole(1.8);
    translate([60, 0, 25])
      screw_hole(2.0);
    translate([80, 0, 25])
      screw_hole(2.2);
    translate([100, 0, 25])
      screw_hole(2.4);
  }
}

module mount_plate(length) {
  // Mount plate module.
  // When printed on its side, this will have:
  // - Height (Z): mount_thickness (8mm) - layers will be vertical in final assembly.
  // - Width (Y): mount_width (100mm) - matches stand mounting surface.
  // - Length (X): length parameter.
  //
  // For printing: rotate 90 degrees around X axis to lay on its side, then 45 degrees around Z for diagonal.
  difference() {
    cube([length, mount_thickness, mount_width]);
    translate([screw_hole_top_spacing, 0, mount_width / 2])
      screw_hole(screw_hole_diameter);
    translate([screw_hole_top_spacing + screw_hole_vertical_spacing, 0, mount_width / 2])
      screw_hole(screw_hole_diameter);
  }
}

mount_plate(325);
//screw_hole_test();
//screw_hole();
