// Flush volume test swatch with stepped squares and a groove cut.

// ---------- Public parameters (mm) ----------
top_square_width = 15;
step_height = 1.2;
second_step_width = 7.5;
first_step_width = 5;
small_step_width = 2;
groove_depth = 0.1;

// ---------- Derived ----------
middle_square_width = top_square_width + second_step_width + small_step_width;
bottom_square_width = middle_square_width + first_step_width + small_step_width;

bottom_square_height = step_height;
middle_square_height = 2 * step_height;
top_square_height = 3 * step_height;

union () {
    translate([2 * small_step_width, 2 * small_step_width, 0]) cube([top_square_width, top_square_width, top_square_height]);
    difference () {
        translate([small_step_width, small_step_width, 0])cube([middle_square_width, middle_square_width, middle_square_height]);
        translate([0, 0, middle_square_height]) rotate([0, 0, 45]) rotate([45, 0, 0]) cube([4 * middle_square_width, groove_depth, groove_depth], center = true);
    }
    cube([bottom_square_width, bottom_square_width, bottom_square_height]);
}
