# OpenSCAD CLI Notes

This file keeps the project-local command examples for `jump-guard`.

For the reusable OpenSCAD CLI guidance and general headless-render notes, use
the shared `openscad-modeling` skill reference at:

`~/.codex/skills/openscad-modeling/references/cli-notes.md`

## macOS binary path

Use the OpenSCAD binary inside the app bundle. Common paths:

- `/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD`
- `/Applications/OpenSCAD-2021.01.app/Contents/MacOS/OpenSCAD`

Set `OPENSCAD` when running the render test script if needed.

## Project commands

### Export the default part
```bash
"/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD" \
  -o exports/gap_guard.stl \
  --hardwarnings \
  --export-format binstl \
  models/gap_guard.scad
```

### Run the render matrix
```bash
OPENSCAD="/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD" \
  tests/run-render-tests.sh
```

### Check one parameter override
```bash
"/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD" \
  -o exports/clip_clearance_0.4.stl \
  --hardwarnings \
  -D 'clip_clearance=0.4' \
  models/gap_guard.scad
```
