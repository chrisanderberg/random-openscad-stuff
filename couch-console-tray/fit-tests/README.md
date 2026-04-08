# Fit Tests

This directory contains low-material validation prints for the couch console
tray. Each test print is its own model and pulls dimensions from
`lib/project/params.scad`, so refinement should mostly happen by changing
shared parameters rather than rewriting the test geometry.

## Test set
- `01-cup-holder-plug`: single-cup plug size test
- `02-cup-spacing-bridge`: verifies two-plug spacing
- `03-rear-tongue-lid-support`: verifies rear tongue and lid-rest geometry
- `04-front-edge-cup-zone`: verifies cup locations relative to tray front edge
- `05-back-gap-fit`: verifies back-side gap alignment
- `06-lip-depth-tester`: compares support lip depth variants
- `07-clearance-coupons`: compares rear tongue thickness and plug diameter
- `08-perimeter-fit-frame`: verifies overall footprint and support lip landing
