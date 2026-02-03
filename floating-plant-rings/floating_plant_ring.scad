// Floating plant ring with a shaped cross-section.

// ---------- Public parameters (mm) ----------
ring_outer_diameter = 150;
cross_section_width = 8;
cross_section_total_height = 8;
top_angle = 30; // Angle of top surfaces in degrees.

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

module floating_ring() {
    rotate_extrude(angle = 360) {
        cross_section();
    }
}

floating_ring();
