# PROJECT.md

## Overview
This project models a cache pot with interchangeable panel patterns. The base
geometry and the decorative panel variants were migrated from the older
`Documents/OpenSCAD` workspace.

## Current shape
- `models/` contains the core and panel variant source files.
- `lib/project/cache_pot_geometry.scad` contains the shared core and panel
  shell helpers used by the variants.
- No older export artifacts were present in the source workspace.

## Design notes
- The defining idea is one core pot shape with multiple panel styles.
- Shared pot geometry now lives in `lib/project/`, while `models/` remains the
  top-level variant layer.
