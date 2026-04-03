// Shared floating plant ring profile helpers.

function ring_inner_radius(ring_outer_diameter, cross_section_width) =
  (ring_outer_diameter - (2 * cross_section_width)) / 2;

function ring_outer_radius(ring_outer_diameter) = ring_outer_diameter / 2;

function ring_center_radius(ring_outer_diameter, cross_section_width) =
  (ring_inner_radius(ring_outer_diameter, cross_section_width) +
   ring_outer_radius(ring_outer_diameter)) / 2;

function triangle_height_from_angle(cross_section_width, top_angle) =
  tan(top_angle) * (cross_section_width / 2);

function rectangle_height_from_total(cross_section_total_height, cross_section_width, top_angle) =
  cross_section_total_height - triangle_height_from_angle(cross_section_width, top_angle);

module ring_cross_section(
  ring_outer_diameter,
  cross_section_width,
  cross_section_total_height,
  top_angle
) {
  inner_r = ring_inner_radius(ring_outer_diameter, cross_section_width);
  outer_r = ring_outer_radius(ring_outer_diameter);
  center_r = ring_center_radius(ring_outer_diameter, cross_section_width);
  rectangle_h = rectangle_height_from_total(
    cross_section_total_height,
    cross_section_width,
    top_angle
  );

  polygon(points = [
    [inner_r, 0],
    [outer_r, 0],
    [outer_r, rectangle_h],
    [center_r, cross_section_total_height],
    [inner_r, rectangle_h]
  ]);
}

module side_cross_section(cross_section_width, cross_section_total_height, top_angle) {
  rectangle_h = rectangle_height_from_total(
    cross_section_total_height,
    cross_section_width,
    top_angle
  );

  polygon(points = [
    [0, 0],
    [cross_section_width, 0],
    [cross_section_width, rectangle_h],
    [cross_section_width / 2, cross_section_total_height],
    [0, rectangle_h]
  ]);
}

module radial_side_cross_section(cross_section_width, cross_section_total_height, top_angle) {
  rectangle_h = rectangle_height_from_total(
    cross_section_total_height,
    cross_section_width,
    top_angle
  );

  polygon(points = [
    [0, 0],
    [cross_section_width * 2, 0],
    [cross_section_width * 2, cross_section_total_height],
    [cross_section_width / 2, cross_section_total_height],
    [0, rectangle_h]
  ]);
}
