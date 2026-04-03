# BOOTSTRAP.md

Use this as a checklist when starting a new small OpenSCAD repository from the
template.

## Quick start

You can copy this template into a new project directory with:

```bash
./scripts/bootstrap-new-project.sh /path/to/new-project --git
```

This copies the template without the template repo's `.git` history.

## File tree
- `README.md`
- `PROJECT.md`
- `REQUIREMENTS.md`
- `AGENTS.md`
- `.gitignore`
- `lib/project/README.md`
- `lib/project/util.scad`
- `lib/vendor/README.md`
- `models/README.md`
- `models/_template.scad`
- `tests/render-matrix.md`
- `exports/README.md`

## Bootstrap steps
1. Replace the root `README.md` with a project-specific summary.
2. Fill in `PROJECT.md` with the part context, intended use, measurements, and
   notes that do not belong in requirements.
3. Fill in `REQUIREMENTS.md` with:
   - hard requirements for fit, geometry, printability, and artifact handling
   - soft requirements for preferred modeling and organization patterns
   - open questions for unresolved measurements or fit assumptions
4. Keep `AGENTS.md` minimal and point agents at `PROJECT.md` and
   `REQUIREMENTS.md`.
5. Implement reusable geometry in `lib/project/` and keep `models/` as thin
   wrappers.
6. Put generated meshes in `exports/`, not in `models/`.
7. Add or update `tests/render-matrix.md` for meaningful parameter sweeps.
