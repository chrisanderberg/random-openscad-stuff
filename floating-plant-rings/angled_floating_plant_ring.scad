// Angled floating plant ring with a shaped cross-section.

// ---------- Public parameters (mm) ----------
ring_outer_diameter = 150;
cross_section_width = 8;
cross_section_total_height = 8;
top_angle = 30; // Angle of top surfaces in degrees.
ring_angle = 90; // Ring sweep in degrees (360 full, 180 half, 90 quarter).

// ---------- Resolution ----------
$fa = 1;
$fs = 1;

// ---------- Derived ----------
// Calculate inner diameter.
ring_inner_diameter = ring_outer_diameter - (2 * cross_section_width);
// Inner and outer radii.
ring_inner_radius = ring_inner_diameter / 2;
ring_outer_radius = ring_outer_diameter / 2;
// Center of cross-section (middle of wall thickness).
ring_center_radius = (ring_inner_radius + ring_outer_radius) / 2;
// Radius used to clip the angled sector (slightly larger than outer radius).
sector_radius = ring_outer_radius + 1;
// Extra height to guarantee the clipping solid fully covers the ring.
sector_height = cross_section_total_height + 1;
sector_step = 5; // Degrees per segment for the clipping sector arc.

// Calculate triangle and rectangle heights from total height and angle.
// Triangle height = tan(angle) * (width / 2).
triangle_height = tan(top_angle) * (cross_section_width / 2);
rectangle_height = cross_section_total_height - triangle_height;

module cross_section() {
    // Create the cross-section: rectangle base + triangle top
    // Rectangle extends from inner to outer radius
    // Triangle is centered on top with peak at middle of cross-section
    polygon(points = [
        // Bottom-left (inner radius, bottom)
        [ring_inner_radius, 0],
        // Bottom-right (outer radius, bottom)
        [ring_outer_radius, 0],
        // Top-right (outer radius, top of rectangle)
        [ring_outer_radius, rectangle_height],
        // Top-center (middle of cross-section, peak of triangle)
        [ring_center_radius, cross_section_total_height],
        // Top-left (inner radius, top of rectangle)
        [ring_inner_radius, rectangle_height]
    ]);
}

module side_profile() {
    polygon(points = [
        // Bottom-left
        [0, 0],
        // Bottom-right
        [cross_section_width, 0],
        // Top-right (top of rectangle)
        [cross_section_width, rectangle_height],
        // Top-center (peak of triangle)
        [cross_section_width / 2, cross_section_total_height],
        // Top-left (top of rectangle)
        [0, rectangle_height]
    ]);
}

module angled_floating_ring(angle = ring_angle) {
    union() {
        ring_slice(angle);
        radial_side(length = ring_outer_radius, side_angle = 0);
        radial_side(length = ring_outer_radius, side_angle = angle);
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

module radial_side(length = ring_outer_radius, side_angle = 0) {
    // Extrude the same profile along the radius to create a straight side.
    rotate([0, 0, side_angle])
        multmatrix([
            [0, 0, 1, 0],
            [1, 0, 0, 0],
            [0, 1, 0, 0],
            [0, 0, 0, 1]
        ])
            translate([-cross_section_width / 2, 0, 0])
                linear_extrude(height = length) {
                    side_profile();
                }
}

module sector_2d(radius, angle, step) {
    polygon(points = concat(
        [[0, 0]],
        [for (a = [0 : step : angle]) [radius * cos(a), radius * sin(a)]],
        [[0, 0]]
    ));
}

angled_floating_ring();
