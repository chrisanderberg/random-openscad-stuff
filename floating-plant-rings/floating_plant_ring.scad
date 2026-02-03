// Floating plant ring with cylindrical cutouts.

// ---------- Public parameters (mm) ----------
outer_diameter = 200;
thickness = 7.5;
spherical_cutout_count = 72;
line_width = 0.82;

// ---------- Resolution ----------
$fa = 1;
$fs = 1;

// ---------- Derived ----------
height = thickness;
inner_diameter = outer_diameter - (2 * thickness);
// Radius at the middle of the wall thickness for cylinder placement.
cylinder_radius_position = (outer_diameter + inner_diameter) / 4;
// Cylinder diameter should account for shells on each side (2 * line_width per side = 4 * line_width total).
cylinder_diameter = thickness - 4 * line_width;
cylinder_height = height * 0.8;

module ring() {
    difference() {
        // Outer cylinder
        cylinder(h = height, d = outer_diameter, center = true);
        
        // Inner cylinder (hole) - 1mm taller to avoid coplanar faces
        cylinder(h = height + 1, d = inner_diameter, center = true);
    }
}

module spherical_cutouts() {
    for (i = [0 : spherical_cutout_count - 1]) {
        angle = 360 * i / spherical_cutout_count;
        rotate([0, 0, angle])
            translate([cylinder_radius_position, 0, 0])
                cylinder(h = cylinder_height, d = cylinder_diameter, center = true);
    }
}

module complete_ring() {
    difference() {
        ring();
        spherical_cutouts();
    }
}

// Uncomment the version you want to see:
complete_ring();
// ring();
//spherical_cutouts();
