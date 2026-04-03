# REQUIREMENTS.md

## Hard requirements
- All dimensions shall use millimeters unless a file explicitly states
  otherwise.
- Experiments shall stay isolated from production project source.
- Source `.scad` files shall live in `models/`.
- Generated artifacts shall live in `exports/`.

## Soft requirements
- Prefer one experiment per file.
- Prefer short comments that explain what a swatch or test is validating.
- Prefer promoting successful experiments into standalone projects instead of
  letting this directory accumulate long-term design work.

## Open questions
- None yet.
