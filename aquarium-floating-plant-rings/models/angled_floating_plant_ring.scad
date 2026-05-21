// Angled floating plant ring with a shaped cross-section.

use <../lib/project/ring_profile.scad>;

// ---------- Public parameters (mm) ----------
ring_outer_diameter = 300;
cross_section_width = 8;
cross_section_total_height = 8;
top_angle = 45; // Angle of top surfaces in degrees.
ring_angle = 90; // Ring sweep in degrees (360 full, 180 half, 90 quarter).

// ---------- Resolution ----------
$fa = 1;
$fs = 1;

// ---------- Derived ----------
ring_outer_radius = ring_outer_diameter / 2;
ring_center_radius = ring_center_radius(ring_outer_diameter, cross_section_width);
// Radius used to clip the angled sector (slightly larger than outer radius).
sector_radius = ring_outer_radius + 1;
// Extra height to guarantee the clipping solid fully covers the ring.
sector_height = cross_section_total_height + 1;
sector_step = 5; // Degrees per segment for the clipping sector arc.
side_extension = cross_section_width * 2;
side_length = ring_outer_radius + side_extension;
radial_side_extra = 0.1;
cleanup_length = ring_outer_diameter;
cleanup_depth = ring_outer_radius;
cleanup_height = cross_section_total_height * 3;

triangle_height = triangle_height_from_angle(cross_section_width, top_angle);
rectangle_height = rectangle_height_from_total(cross_section_total_height, cross_section_width, top_angle);

// ---------- Cross-section profiles ----------
module cross_section() {
    ring_cross_section(
      ring_outer_diameter = ring_outer_diameter,
      cross_section_width = cross_section_width,
      cross_section_total_height = cross_section_total_height,
      top_angle = top_angle
    );
}

module side_profile() {
    side_cross_section(
      cross_section_width = cross_section_width,
      cross_section_total_height = cross_section_total_height,
      top_angle = top_angle
    );
}

module radial_side_profile() {
    radial_side_cross_section(
      cross_section_width = cross_section_width,
      cross_section_total_height = cross_section_total_height,
      top_angle = top_angle
    );
}

// ---------- Union construction ----------
module angled_floating_ring_cleaned(angle = ring_angle) {
    intersection() {
        intersection() {
            difference() {
                angled_floating_ring_union(angle);
                first_radial_vertical_cleanup_volume();
                first_radial_angled_top_cleanup_volume();
                second_radial_vertical_cleanup_volume();
                second_radial_angled_top_cleanup_volume();
            }
            outer_arc_vertical_cleanup_volume();
        }
        outer_arc_angled_top_cleanup_volume();
    }
}

module angled_floating_ring_union(angle = ring_angle) {
    union() {
        ring_slice(angle);
        radial_side(length = side_length, reflect = true);
        rotate([0, 0, angle])
            radial_side(length = side_length);
    }
}

module full_ring() {
    rotate_extrude(angle = 360) {
        cross_section();
    }
}

module ring_slice(angle = ring_angle) {
    intersection() {
        full_ring();
        ring_sector(angle);
    }
}

module ring_sector(angle = ring_angle) {
    translate([0, 0, -0.5]) {
        linear_extrude(height = sector_height) {
            sector_2d(sector_radius, angle, sector_step);
        }
    }
}

// ---------- Radial sides ----------
module radial_side(length = ring_outer_radius, reflect = false) {
    // Extrude the same profile along the radius to create a straight side.
    rotate([0, 90, 0])
    rotate([0, 0, 90])
          if (reflect)
            mirror([1, 0, 0])
            translate([-cross_section_width / 2, 0, -side_extension])
              linear_extrude(height = length) {
                  radial_side_profile();
              }
          else
            translate([-cross_section_width / 2, 0, -side_extension])
            linear_extrude(height = length) {
                radial_side_profile();
            }
}


// ---------- Radial cleanup volumes ----------
module first_radial_vertical_cleanup_volume() {
    // Large slab aligned to the first radial side (side_angle = 0).
    translate([-ring_outer_radius, -ring_outer_radius - cross_section_width / 2, -cross_section_total_height])
      cube([cleanup_length, cleanup_depth, cleanup_height]);
}

module first_radial_angled_top_cleanup_volume() {
    // Large angled slab aligned to the first radial side (side_angle = 0).
    translate([0, 0, cross_section_total_height])
    rotate([top_angle - 90, 0, 0])
      translate([-ring_outer_radius, -ring_outer_radius, -cross_section_total_height])
        cube([cleanup_length, cleanup_depth, cleanup_height]);
}

module second_radial_vertical_cleanup_volume() {
    rotate([0, 0, ring_angle])
      translate([-ring_outer_radius, cross_section_width / 2, -cross_section_total_height])
        cube([cleanup_length, cleanup_depth, cleanup_height]);
}

module second_radial_angled_top_cleanup_volume() {
    // Large angled slab aligned to the second radial side (side_angle = ring_angle).
    rotate([0, 0, ring_angle])
      translate([0, 0, cross_section_total_height])
        rotate([-90 - top_angle, 0, 0])
          translate([-ring_outer_radius, -ring_outer_radius, -cross_section_total_height])
            cube([cleanup_length, cleanup_depth, cleanup_height]);
}

// ---------- Outer arc cleanup volumes ----------
module outer_arc_vertical_cleanup_volume() {
    translate([0, 0, cross_section_total_height / 2])
        cylinder(h = cleanup_height, r = ring_outer_radius, center = true);
}

module outer_arc_angled_top_cleanup_volume() {
    // Cone matching the outer angled top surface.
    extra_height = cross_section_total_height;
    slope = (ring_outer_radius - ring_center_radius) / triangle_height;
    total_height = triangle_height + extra_height;
    bottom_radius = ring_center_radius + (slope * total_height);
    translate([0, 0, rectangle_height - extra_height])
        cylinder(h = total_height, r1 = bottom_radius, r2 = ring_center_radius);
}

// ---------- Utility ----------
module sector_2d(radius, angle, step) {
    polygon(points = concat(
        [[0, 0]],
        [for (a = [0 : step : angle]) [radius * cos(a), radius * sin(a)]],
        [[0, 0]]
    ));
}

// angled_floating_ring_union();
angled_floating_ring_cleaned();
