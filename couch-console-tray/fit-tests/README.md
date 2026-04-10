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
- `06-lip-depth-tester`: verifies support lip depth at the front corner
- `07-clearance-coupons`: verifies rear tongue thickness with a simple coupon
- `08-perimeter-fit-frame`: verifies overall footprint and support lip landing
- `09-front-corner-wrap-fit`: prints one mirrored half of the lip-only front-and-sides wrap so the full test can be glued from two halves
- `10-front-to-back-cup-plug-section`: prints a thin center slice through one cup plug and surrounding tray geometry
- `11-top-rim-rabbet-corner-fit`: prints matching body and rim corner coupons to verify rabbet fit before committing to full parts
- `12-side-to-side-cup-plug-section`: prints one mirrored half of a side-to-side center slice through the tray and cup-plug profile
