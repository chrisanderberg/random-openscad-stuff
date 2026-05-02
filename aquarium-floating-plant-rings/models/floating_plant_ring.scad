// Floating plant ring with a shaped cross-section.

use <../lib/project/ring_profile.scad>;

// ---------- Public parameters (mm) ----------
ring_outer_diameter = 150;
cross_section_width = 8;
cross_section_total_height = 8;
top_angle = 30; // Angle of top surfaces in degrees.

// ---------- Resolution ----------
$fa = 1;
$fs = 1;

// ---------- Derived ----------
module floating_ring() {
    rotate_extrude(angle = 360) {
        ring_cross_section(
          ring_outer_diameter = ring_outer_diameter,
          cross_section_width = cross_section_width,
          cross_section_total_height = cross_section_total_height,
          top_angle = top_angle
        );
    }
}

floating_ring();
