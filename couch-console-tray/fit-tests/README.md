# Fit Tests

This directory contains low-material validation prints for the couch console
tray. Each test print is its own model and pulls dimensions from
`lib/project/params.scad`, so refinement should mostly happen by changing
shared parameters rather than rewriting the test geometry.

## Active test set
- `cup-spacing-bridge`: verifies two-plug spacing and cup-plug relationship
- `perimeter-fit-frame`: verifies overall footprint and support lip landing
- `front-to-back-cup-plug-section`: literal slice of the assembled tray through one cup plug in the front-to-back direction
- `top-rim-rabbet-corner-fit`: verifies body-to-rim rabbet fit with matching corner coupons
- `side-to-side-cup-plug-section`: literal slice of the assembled tray through the cup-plug profile in the side-to-side direction

These are the only fit tests kept in this project.
