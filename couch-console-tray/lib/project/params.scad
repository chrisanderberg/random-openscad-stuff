// lib/project/params.scad
// Shared project parameters for the final tray and all fit-test models.

debug = false;

// Main tray footprint.
tray_corner_r = 15;

// Top tray shell.
tray_floor_t = 2.4;
tray_wall_h = 14;
top_wall_w = 10;
rim_inner_taper = 4.0;
glue_rabbet_h = 1.6;
glue_rabbet_w = 3.2;
glue_rabbet_side_clearance = 0.3;
glue_rabbet_vertical_clearance = 0.5;

// Underside support lip and rear support section.
support_lip_drop = 15;
support_lip_w = 10;
front_lip_forward_shift = 2;
front_lip_back_extra = 5;
front_lip_bottom_back_extra = 0;
side_lip_inner_extra = 2.5;
side_lip_bottom_inner_extra = 0;
console_clear_w = 320;
side_lip_run = 170;
tray_w = console_clear_w + 2 * support_lip_w;
tray_d = side_lip_run + support_lip_w;
front_extension = 45;
rear_gap_w = 28;
rear_tongue_side_margin = 20;
rear_tongue_w = tray_w - 2 * rear_tongue_side_margin;
rear_tongue_depth = 29;
rear_tongue_t = 4.0;

// Cup holder location and plug geometry.
cup_spacing = 135;
// Confirmed from fit checks: move plugs 39 mm rearward from the prior position.
cup_y_from_front = 111;
full_plug_top_d = 90;
full_plug_bottom_d = 78;
full_plug_h = 71;
plug_depth_fraction = 0.333333;
plug_top_d = full_plug_top_d;
plug_bottom_d =
  plug_depth_fraction * full_plug_bottom_d +
  (1.0 - plug_depth_fraction) * full_plug_top_d;
plug_h = full_plug_h * plug_depth_fraction;
plug_shell_t = 1.6;
plug_clearance_z = 0;
cup_rim_w = 7;
cup_rim_h = 5;

// Optional underside splice plate for joining printed tray halves.
splice_plate_enable = true;
splice_plate_w = 120;
splice_plate_d = 18;
splice_plate_t = 2;
splice_plate_corner_r = 3;
splice_plate_y_from_front = 40;
splice_plate_side_clearance = 0.3;
splice_plate_vertical_clearance = 0.5;
rear_splice_plate_enable = true;
rear_splice_plate_y_from_front = 184;

// Fit-test defaults.
test_plug_top_ds = [84, 85, 86];
test_spacing_values = [116, 118, 120];
test_lip_drop_values = [8, 10, 12];
test_rear_tongue_ts = [1.4, 1.8, 2.2];
test_frame_wall_w = 12;
test_front_zone_depth = 100;
test_rear_zone_depth = 56;
test_gap_section_w = 140;
test_coupon_spacing = 18;
test_front_to_back_slice_w = 10;
test_side_to_side_slice_w = 10;
test_rabbet_corner_section_size = 56;
test_rabbet_coupon_gap = 16;
test_rabbet_body_margin_from_groove = 15;
