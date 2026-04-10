// models/tray.scad
// Main tray body without the removable top rim.

use <../lib/project/console_tray.scad>;
include <../lib/project/params.scad>;

// ---------- Public parameters (mm) ----------
// Parameters are shared from lib/project/params.scad.

module main() {
  tray_body_variant(
    tray_w = tray_w,
    tray_d = tray_d,
    front_extension = front_extension,
    tray_corner_r = tray_corner_r,
    tray_floor_t = tray_floor_t,
    top_wall_w = top_wall_w,
    glue_rabbet_h = glue_rabbet_h,
    glue_rabbet_w = glue_rabbet_w,
    glue_rabbet_side_clearance = glue_rabbet_side_clearance,
    glue_rabbet_vertical_clearance = glue_rabbet_vertical_clearance,
    support_lip_drop = support_lip_drop,
    support_lip_w = support_lip_w,
    rear_gap_w = rear_gap_w,
    rear_tongue_w = rear_tongue_w,
    rear_tongue_depth = rear_tongue_depth,
    rear_tongue_t = rear_tongue_t,
    cup_spacing = cup_spacing,
    cup_y_from_front = cup_y_from_front,
    plug_top_d = plug_top_d,
    plug_bottom_d = plug_bottom_d,
    plug_h = plug_h,
    plug_shell_t = plug_shell_t,
    cup_rim_w = cup_rim_w,
    cup_rim_h = cup_rim_h,
    splice_plate_enable = splice_plate_enable,
    splice_plate_w = splice_plate_w,
    splice_plate_d = splice_plate_d,
    splice_plate_t = splice_plate_t,
    splice_plate_corner_r = splice_plate_corner_r,
    splice_plate_y_from_front = splice_plate_y_from_front,
    splice_plate_side_clearance = splice_plate_side_clearance,
    splice_plate_vertical_clearance = splice_plate_vertical_clearance,
    rear_splice_plate_enable = rear_splice_plate_enable,
    rear_splice_plate_y_from_front = rear_splice_plate_y_from_front,
    plug_clearance_z = plug_clearance_z,
    debug = debug
  );
}

main();
