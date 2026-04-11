// models/right_rim.scad
// Right printable tray rim segment outside the 250 mm center span.

use <../lib/project/console_tray.scad>;
include <../lib/project/params.scad>;

// ---------- Public parameters (mm) ----------
rim_center_piece_span_x = 250;

module main() {
  tray_rim_piece_variant(
    tray_w = tray_w,
    tray_d = tray_d,
    front_extension = front_extension,
    tray_corner_r = tray_corner_r,
    tray_wall_h = tray_wall_h,
    top_wall_w = top_wall_w,
    rim_inner_taper = rim_inner_taper,
    glue_rabbet_h = glue_rabbet_h,
    glue_rabbet_w = glue_rabbet_w,
    glue_rabbet_side_clearance = glue_rabbet_side_clearance,
    glue_rabbet_vertical_clearance = glue_rabbet_vertical_clearance,
    center_piece_span_x = rim_center_piece_span_x,
    piece = "right"
  );
}

main();
