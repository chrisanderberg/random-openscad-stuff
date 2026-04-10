// models/half_tray.scad
// Printable half of the full tray for smaller print beds.

use <../lib/project/console_tray.scad>;
include <../lib/project/params.scad>;

// ---------- Public parameters (mm) ----------
// Set false to export the opposite half without changing the shared tray model.
keep_left_half = true;

module full_tray() {
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
    front_lip_back_extra = front_lip_back_extra,
    front_lip_bottom_back_extra = front_lip_bottom_back_extra,
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

module half_tray(keep_left_half = true) {
  base_h = tray_base_h(tray_floor_t, cup_rim_h);
  cut_x = max(tray_w, rear_tongue_w, cup_spacing + plug_top_d) + 20;
  cut_y = tray_d + front_extension + rear_tongue_depth + 20;
  cut_z = plug_h + support_lip_drop + base_h + 20;
  keep_sign = keep_left_half ? 1 : -1;

  difference() {
    full_tray();

    // Remove one side at the center plane so the remaining half can be mirrored.
    translate([keep_sign * cut_x / 4, 0, (base_h - plug_h - support_lip_drop) / 2])
      cube([cut_x / 2, cut_y, cut_z], center = true);
  }
}

half_tray(keep_left_half = keep_left_half);
