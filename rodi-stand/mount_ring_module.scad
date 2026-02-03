// rodi-stand/mount_ring_module.scad
// Shared RO/DI mount ring modules.

module wedge() {
  wedge_radius = mount_ring_outer_diameter + 1;
  rotate([0, 0, -90 - mount_opening_angle / 2])
  translate([0, 0, -1])
    linear_extrude(height = mount_ring_height + 2) {
      polygon(points = [
        [0, 0],
        [wedge_radius, 0],
        [cos(mount_opening_angle) * wedge_radius, sin(mount_opening_angle) * wedge_radius]
      ]);
    }
}

module screw_cutout() {
  translate([0, 0, mount_ring_height / 2])
  rotate([-90, 0, 0])
  union() {
    cylinder(mount_ring_inner_diameter / 2 + mount_surface_extension + 1, screw_hole_diameter / 2, screw_hole_diameter / 2);
    cylinder(mount_ring_inner_diameter / 2 + mount_surface_extension - screw_wall_width, screw_access_diameter / 2, screw_access_diameter / 2);
  }
}

module mount_ring() {
  difference() {
    union() {
      translate([-mount_surface_width / 2, 0, 0])
        cube([mount_surface_width, mount_ring_inner_diameter / 2 + mount_surface_extension, mount_ring_height]);
      cylinder(mount_ring_height, mount_ring_outer_diameter / 2, mount_ring_outer_diameter / 2);
    };
    translate([0, 0, -1])
      cylinder(mount_ring_height + 2, mount_ring_inner_diameter / 2, mount_ring_inner_diameter / 2);
    wedge();
    translate([screw_spacing / 2, 0, 0])
      screw_cutout();
    translate([-screw_spacing / 2, 0, 0])
      screw_cutout();
  }
}
