// RO/DI mount ring.

use <../lib/project/mount_ring_module.scad>;

// ---------- Public parameters (mm) ----------
mount_ring_outer_diameter = 68;
mount_ring_inner_diameter = 60.5;
mount_ring_height = 20;
mount_surface_width = 65;
mount_surface_extension = 20;
mount_opening_angle = 120;
screw_spacing = 30;
screw_wall_width = 5;
screw_hole_diameter = 5;
screw_access_diameter = 10;


mount_ring();
//screw_cutout();
//wedge();
