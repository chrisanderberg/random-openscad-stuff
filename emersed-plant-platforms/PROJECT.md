# PROJECT.md

## Overview
This project contains printable emersed plant platforms sized for different
container shapes. The platforms support plants above nutrient-rich water while
leaving openings for roots to extend downward.

## Current shape
- Rectangle and polygon-based platform variants live in `models/`.
- Existing exported meshes from the older workspace were copied into `exports/`
  for comparison and validation.

## Design notes
- The platforms use a light, open structure with a solid rim.
- Container-specific variants are mainly parameterized versions of the shared
  platform idea.
- This migration preserves the older source files first; deeper refactoring can
  happen later if the project becomes active again.
