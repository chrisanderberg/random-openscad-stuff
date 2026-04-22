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
fork_depth = 4.0;

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

// Local fork boundary from top root to bottom root.
// Root is at x = 0 and tip is at x = fork_length.
function fork_points(fork_length, width, gap_width, fork_depth) =
  let(
    outer_y = width / 2,
    inner_y = gap_width / 2,
    prong_width = (width - gap_width) / 2,
    tip_round = min(prong_width * 0.55, 0.9),
    slot_root_r = min(inner_y, 1.0),
    slot_root_x = min(max(fork_depth, 3.5), fork_length - 3.0),
    nub_height = max(0.28, prong_width * 0.14),
    nub_start = min(fork_length - 3.0, slot_root_x + (fork_length - slot_root_x) * 0.58),
    nub_end = min(fork_length - 1.8, nub_start + max(0.35, fork_length * 0.025)),
    tip_mid_y = inner_y + prong_width / 2
  ) [
    [0, outer_y],
    [nub_start, outer_y],
    [nub_end, outer_y + nub_height],
    [fork_length - tip_round, outer_y],
    [fork_length, tip_mid_y],
    [fork_length - tip_round, inner_y],
    [slot_root_x, inner_y],
    [slot_root_x - slot_root_r, 0],
    [slot_root_x, -inner_y],
    [fork_length - tip_round, -inner_y],
    [fork_length, -tip_mid_y],
    [fork_length - tip_round, -outer_y],
    [nub_end, -(outer_y + nub_height)],
    [nub_start, -outer_y],
    [0, -outer_y]
  ];

lower_body_axis = v_dir(bend_angle);
upper_body_axis = [1, 0];

lower_body_normal = v_perp(lower_body_axis);
upper_body_normal = v_perp(upper_body_axis);

lower_tip = [0, 0];
lower_root = v_add(lower_tip, v_scale(lower_body_axis, lower_fork_length));
bend_point = v_add(lower_tip, v_scale(lower_body_axis, bend_location));
upper_tip = v_add(bend_point, v_scale(upper_body_axis, total_length - bend_location));
upper_root = v_add(upper_tip, v_scale(upper_body_axis, -upper_fork_length));

top_bend = line_intersection(
  v_add(lower_root, v_scale(lower_body_normal, body_width / 2)), lower_body_axis,
  v_add(upper_root, v_scale(upper_body_normal, body_width / 2)), upper_body_axis
);

bottom_bend = line_intersection(
  v_add(lower_root, v_scale(lower_body_normal, -body_width / 2)), lower_body_axis,
  v_add(upper_root, v_scale(upper_body_normal, -body_width / 2)), upper_body_axis
);

lower_fork = transform_points(
  fork_points(lower_fork_length, body_width, fork_gap_width, fork_depth),
  lower_root,
  v_scale(lower_body_axis, -1),
  lower_body_normal
);

upper_fork = transform_points(
  fork_points(upper_fork_length, body_width, fork_gap_width, fork_depth),
  upper_root,
  upper_body_axis,
  upper_body_normal
);

outline_points = concat(
  [lower_fork[0]],
  [top_bend],
  upper_fork,
  [bottom_bend],
  rev(lower_fork)
);

linear_extrude(height = thickness)
  polygon(points = outline_points);
