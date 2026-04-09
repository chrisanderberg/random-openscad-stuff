// lib/project/params.scad
// Shared project parameters for the final tray and all fit-test models.

debug = false;

// Main tray footprint.
tray_corner_r = 15;

// Top tray shell.
tray_floor_t = 2.4;
tray_wall_h = 14;
top_wall_w = 10;
glue_rabbet_h = 1.6;
glue_rabbet_w = 3.2;
glue_rabbet_side_clearance = 0.5;
glue_rabbet_vertical_clearance = 0.25;

// Underside support lip and rear support section.
support_lip_drop = 15;
support_lip_w = 10;
console_clear_w = 320;
side_lip_run = 170;
tray_w = console_clear_w + 2 * support_lip_w;
tray_d = side_lip_run + support_lip_w;
front_extension = 35;
rear_gap_w = 28;
rear_tongue_side_margin = 20;
rear_tongue_w = tray_w - 2 * rear_tongue_side_margin;
rear_tongue_depth = 34;
rear_tongue_t = 3.6;

// Cup holder location and plug geometry.
cup_spacing = 135;
// Confirmed from fit checks: move plugs 39 mm rearward from the prior position.
cup_y_from_front = 111;
plug_top_d = 90;
plug_bottom_d = 78;
plug_h = 73;
plug_shell_t = 1.6;
plug_clearance_z = 0;
cup_rim_w = 10;
cup_rim_h = 5;

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
