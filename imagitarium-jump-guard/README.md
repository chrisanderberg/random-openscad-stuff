# Imagitarium Jump Guard

A 3D-printable rear gap guard for a shallow Imagitarium tank. The part covers
the opening between the lid and the back glass so a betta (or other fish)
cannot jump out. It clips onto the back glass and does not support the lid.

- **Units:** millimeters (mm)
- **Target:** OpenSCAD stable
- **Material:** PETG (clear preferred)

## Project layout

| Path | Purpose |
|------|--------|
| `PROJECT.md` | Context, goals, and notes that do not belong in requirements |
| `REQUIREMENTS.md` | Hard and soft requirements for the part |
| `AGENTS.md` | Minimal workflow instructions for coding agents |
| `openscad-cli.md` | Headless OpenSCAD on macOS (export STL, run checks) |
| `lib/project/` | Reusable OpenSCAD modules (e.g. `util.scad`) |
| `lib/vendor/` | Third-party libraries (optional) |
| `models/` | Top-level model files (thin wrappers; main guard: `gap_guard.scad` when present) |
| `tests/` | Render/validation matrix (`render-matrix.md`) |
| `exports/` | Generated STL/3MF and render test outputs (gitignored) |

## Quick start

1. Open a model in OpenSCAD (e.g. `models/gap_guard.scad`).
2. Adjust parameters at the top of the file if needed.
3. Render (F6) and export STL, or use the CLI for headless export (see below).

## Headless export (macOS)

Use the OpenSCAD binary inside the app bundle so Qt finds its libraries. See
**openscad-cli.md** for the project-local command examples.

Example (adjust app path/version to match your install):

```bash
/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD \
  -o exports/gap_guard.stl \
  --hardwarnings \
  --export-format binstl \
  models/gap_guard.scad
```

## Conventions

- **Docs:** kebab-case (e.g. `render-matrix.md`, `requirements.md`)
- **OpenSCAD:** snake_case (e.g. `gap_guard.scad`, `util.scad`)
- **Requirements-driven:** Keep binding constraints in `REQUIREMENTS.md` and general context in `PROJECT.md`.
- **Artifacts:** Keep generated meshes in `exports/`, not next to source `.scad` files.

## References

- `PROJECT.md` — design context and modeling notes
- `REQUIREMENTS.md` — fit, printability, and structure constraints
- `openscad-cli.md` — CLI export notes
- `tests/render-matrix.md` — render validation cases
