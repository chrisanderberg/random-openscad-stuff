// lib/project/util.scad

module rounded_rect_2d(size = [10, 10], r = 2) {
  x = size[0];
  y = size[1];
  rr = min(r, min(x, y) / 2);

  hull() {
    for (sx = [-1, 1], sy = [-1, 1]) {
      translate([sx * (x / 2 - rr), sy * (y / 2 - rr)])
        circle(r = rr);
    }
  }
}
