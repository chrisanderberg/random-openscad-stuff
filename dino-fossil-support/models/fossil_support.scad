// models/fossil_support.scad
// One closed 2D polygon extruded to thickness.
// Both forked ends come from the same point generator.

// ---------- Public parameters (mm) ----------
total_length = 130;
body_width = 5.55;
thickness = 3.95;
thick_body_width = 8;
thick_thickness = 6;
middle_chamfer = 0.75;

lower_fork_length = 15;
upper_fork_length = 15;
fork_gap_width = 2.0;
fork_depth = 4.0;

bend_angle = 15;
bend_location = 25;
upper_bend_angle = 0;   // set to 0 for the original single-bend overall shape
upper_bend_location = 25;

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

function safe_middle_chamfer(requested, width, height) =
  max(0, min(requested, width / 2 - 0.01, height / 2 - 0.01));

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

// ---------- Centerline geometry ----------
lower_axis = v_dir(bend_angle);
middle_axis = [1, 0];
upper_axis = v_dir(upper_bend_angle);

lower_normal = v_perp(lower_axis);
middle_normal = v_perp(middle_axis);
upper_normal = v_perp(upper_axis);

lower_tip = [0, 0];
lower_root = v_add(lower_tip, v_scale(lower_axis, lower_fork_length));
lower_bend = v_add(lower_tip, v_scale(lower_axis, bend_location));

middle_length = total_length - bend_location - upper_bend_location;
upper_bend = v_add(lower_bend, v_scale(middle_axis, middle_length));
upper_tip = v_add(upper_bend, v_scale(upper_axis, upper_bend_location));
upper_root = v_add(upper_tip, v_scale(upper_axis, -upper_fork_length));

// ---------- Four non-fork polygon points ----------
lower_top_bend = line_intersection(
  v_add(lower_bend, v_scale(lower_normal, body_width / 2)), lower_axis,
  v_add(lower_bend, v_scale(middle_normal, body_width / 2)), middle_axis
);

upper_top_bend = line_intersection(
  v_add(upper_bend, v_scale(middle_normal, body_width / 2)), middle_axis,
  v_add(upper_bend, v_scale(upper_normal, body_width / 2)), upper_axis
);

upper_bottom_bend = line_intersection(
  v_add(upper_bend, v_scale(middle_normal, -body_width / 2)), middle_axis,
  v_add(upper_bend, v_scale(upper_normal, -body_width / 2)), upper_axis
);

lower_bottom_bend = line_intersection(
  v_add(lower_bend, v_scale(lower_normal, -body_width / 2)), lower_axis,
  v_add(lower_bend, v_scale(middle_normal, -body_width / 2)), middle_axis
);

middle_top_start = line_intersection(
  v_add(lower_bend, v_scale(lower_normal, thick_body_width / 2)), lower_axis,
  v_add(lower_bend, v_scale(middle_normal, thick_body_width / 2)), middle_axis
);

middle_top_end = line_intersection(
  v_add(upper_bend, v_scale(middle_normal, thick_body_width / 2)), middle_axis,
  v_add(upper_bend, v_scale(upper_normal, thick_body_width / 2)), upper_axis
);

middle_bottom_end = line_intersection(
  v_add(upper_bend, v_scale(middle_normal, -thick_body_width / 2)), middle_axis,
  v_add(upper_bend, v_scale(upper_normal, -thick_body_width / 2)), upper_axis
);

middle_bottom_start = line_intersection(
  v_add(lower_bend, v_scale(lower_normal, -thick_body_width / 2)), lower_axis,
  v_add(lower_bend, v_scale(middle_normal, -thick_body_width / 2)), middle_axis
);

// ---------- Forks ----------
fork_profile_lower = fork_points(lower_fork_length, body_width, fork_gap_width, fork_depth);
fork_profile_upper = fork_points(upper_fork_length, body_width, fork_gap_width, fork_depth);

lower_fork = transform_points(
  fork_profile_lower,
  lower_root,
  v_scale(lower_axis, -1),
  lower_normal
);

upper_fork = transform_points(
  fork_profile_upper,
  upper_root,
  upper_axis,
  upper_normal
);

outline_points = concat(
  [lower_fork[0]],
  [lower_top_bend, upper_top_bend],
  upper_fork,
  [upper_bottom_bend, lower_bottom_bend],
  rev(lower_fork)
);

middle_outline_points = [
  middle_top_start,
  middle_top_end,
  middle_bottom_end,
  middle_bottom_start
];

middle_chamfer_mm = safe_middle_chamfer(
  middle_chamfer,
  thick_body_width,
  thick_thickness
);

module octahedron(radius) {
  polyhedron(
    points = [
      [ radius, 0, 0],
      [-radius, 0, 0],
      [0,  radius, 0],
      [0, -radius, 0],
      [0, 0,  radius],
      [0, 0, -radius]
    ],
    faces = [
      [0, 2, 4],
      [2, 1, 4],
      [1, 3, 4],
      [3, 0, 4],
      [2, 0, 5],
      [1, 2, 5],
      [3, 1, 5],
      [0, 3, 5]
    ]
  );
}

module middle_section() {
  z0 = (thickness - thick_thickness) / 2;

  translate([0, 0, z0])
    if (middle_chamfer_mm > 0) {
      minkowski() {
        translate([0, 0, middle_chamfer_mm])
          linear_extrude(height = thick_thickness - 2 * middle_chamfer_mm)
            offset(delta = -middle_chamfer_mm)
              polygon(points = middle_outline_points);
        octahedron(middle_chamfer_mm);
      }
    } else {
      linear_extrude(height = thick_thickness)
        polygon(points = middle_outline_points);
    }
}

union() {
  linear_extrude(height = thickness)
    polygon(points = outline_points);

  middle_section();
}
