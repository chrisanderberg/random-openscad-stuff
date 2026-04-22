// models/fossil_support.scad
// One closed 2D polygon extruded to thickness.
// Both forked ends come from the same point generator.

// ---------- Public parameters (mm) ----------
total_length = 235;
body_width = 9;
thickness = 6;

lower_fork_length = 20;
upper_fork_length = 20;
fork_gap_width = 2.6;
fork_depth = 4.0; // kept as a top-level parameter per project contract

bend_angle = 15;
bend_location = 46;

// ---------- Vector helpers ----------
function v_add(a, b) = [a[0] + b[0], a[1] + b[1]];
function v_sub(a, b) = [a[0] - b[0], a[1] - b[1]];
function v_scale(v, s) = [v[0] * s, v[1] * s];
function v_perp(v) = [-v[1], v[0]];
function v_dir(angle_deg) = [cos(angle_deg), sin(angle_deg)];
function cross2(a, b) = a[0] * b[1] - a[1] * b[0];
function rev(points) = [for (i = [len(points) - 1 : -1 : 0]) points[i]];

function line_intersection(p, r, q, s) =
  let(rxs = cross2(r, s))
  abs(rxs) < 1e-9
    ? p
    : v_add(p, v_scale(r, cross2(v_sub(q, p), s) / rxs));

function frame_point(origin, axis, normal, p) =
  v_add(origin, v_add(v_scale(axis, p[0]), v_scale(normal, p[1])));

function transform_points(points, origin, axis, normal) =
  [for (p = points) frame_point(origin, axis, normal, p)];

// Local fork outline.
// Tip is at x = 0. Body/root is at x = fork_length.
// Point order follows the polygon boundary from upper outside, into the slot,
// then back out to the lower outside.
function fork_points(fork_length, width, gap_width) = [
  [0,            width / 2],
  [fork_length,  width / 2],
  [fork_length,  gap_width / 2],
  [0,            gap_width / 2],
  [0,           -gap_width / 2],
  [fork_length, -gap_width / 2],
  [fork_length, -width / 2],
  [0,           -width / 2]
];

lower_axis = v_dir(bend_angle);
upper_axis = [1, 0];

lower_normal = v_perp(lower_axis);
upper_normal = v_perp(upper_axis);

lower_tip = [0, 0];
bend_point = v_add(lower_tip, v_scale(lower_axis, bend_location));
upper_tip = v_add(bend_point, v_scale(upper_axis, total_length - bend_location));

top_bend = line_intersection(
  v_add(bend_point, v_scale(lower_normal, body_width / 2)), lower_axis,
  v_add(bend_point, v_scale(upper_normal, body_width / 2)), upper_axis
);

bottom_bend = line_intersection(
  v_add(bend_point, v_scale(lower_normal, -body_width / 2)), lower_axis,
  v_add(bend_point, v_scale(upper_normal, -body_width / 2)), upper_axis
);

lower_fork = transform_points(
  fork_points(lower_fork_length, body_width, fork_gap_width),
  lower_tip,
  lower_axis,
  lower_normal
);

upper_fork = transform_points(
  fork_points(upper_fork_length, body_width, fork_gap_width),
  upper_tip,
  v_scale(upper_axis, -1),
  upper_normal
);

outline_points = concat(
  [for (i = [0, 1]) lower_fork[i]],
  [top_bend],
  [for (i = [1, 0, 3, 2, 5, 4, 7, 6]) upper_fork[i]],
  [bottom_bend],
  [for (i = [6, 7, 4, 5, 2, 3]) lower_fork[i]]
);

linear_extrude(height = thickness)
  polygon(points = outline_points);
