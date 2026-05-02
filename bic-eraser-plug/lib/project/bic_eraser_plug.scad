// Reusable geometry for Bic mechanical pencil eraser replacement plugs.
// Z origin is at the bottom of the insert; +Z points toward the eraser cap.

module bic_eraser_plug(
  insert_diameter,
  insert_height,
  head_diameter = 0,
  head_height = 0,
  bottom_chamfer = 0.4,
  top_chamfer = 0.4
) {
  effective_head_diameter = head_diameter > 0 ? head_diameter : insert_diameter;
  effective_head_height = head_height > 0 ? head_height : 0;
  body_height = insert_height - effective_head_height;
  insert_radius = insert_diameter / 2;
  head_radius = effective_head_diameter / 2;
  bottom_chamfer_radius = min(bottom_chamfer, insert_radius, body_height, insert_height / 2);
  top_chamfer_radius = min(
    top_chamfer,
    head_radius,
    effective_head_height > 0 ? effective_head_height : insert_height,
    insert_height / 2
  );
  body_top_z = effective_head_height > 0 ? body_height : insert_height;
  top_start_z = insert_height - top_chamfer_radius;

  if (body_height <= 0) {
    assert(false, "insert_height must be larger than head_height");
  }

  rotate_extrude()
    polygon(concat(
      [[0, 0]],
      bottom_chamfer_radius > 0
        ? [[insert_radius - bottom_chamfer_radius, 0], [insert_radius, bottom_chamfer_radius]]
        : [[insert_radius, 0]],
      [[insert_radius, body_top_z]],
      effective_head_height > 0 && effective_head_diameter != insert_diameter
        ? [[head_radius, body_top_z]]
        : [],
      top_chamfer_radius > 0
        ? [[head_radius, top_start_z], [head_radius - top_chamfer_radius, insert_height]]
        : [[head_radius, insert_height]],
      [[0, insert_height]]
    ));
}
