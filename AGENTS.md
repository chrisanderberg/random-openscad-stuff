# AGENTS.md (OpenSCAD Projects Root)

## Purpose
This repo is a collection of small OpenSCAD projects. Each project lives in its
own folder with its own `spec.md` and `plan.md`. The goal is to keep things
lightweight, modular, and easy to iterate without forcing a heavyweight structure.

See `style-guide.md` for repo-wide naming and coding conventions.

## Target environment
- OpenSCAD: most recent stable release (not nightly).
- Units: millimeters (mm) unless a file explicitly states otherwise.
- Coordinate system: Z up.

## Authority and change control (important)
- Each project folder owns its own `spec.md` and defines the "what" for that
  project.
- Do NOT modify any `spec.md` unless the user explicitly instructs you to.
- If a `spec.md` is missing details or contains conflicts:
  - ask targeted questions, OR
  - propose a change in chat labeled "PROPOSED SPEC CHANGE" and wait for
    approval before editing that `spec.md`.
- `plan.md` and implementation files may be updated as needed to satisfy the
  local `spec.md`, but must remain consistent with it.

## Repo structure
- Root contains multiple project folders (e.g., `rodi-stand/`,
  `emersed-anubias-platforms/`, `floating-plant-rings/`, `paneled-cache-pot/`,
  `experiments/`).
- Each project folder contains:
  - `spec.md`
  - `plan.md`
  - one or more `.scad` files
  - optional exported artifacts (`.stl`, `.3mf`, etc.)

## Workflow (spec-driven per project)
1. Identify which project folder applies.
2. Read that folder's `spec.md` first.
3. Read that folder's `plan.md` next and implement in small, verifiable steps.
4. Update that folder's `plan.md` if approach changes or new steps are
   discovered during implementation.

## Example pattern
Use `template.scad` at the repo root as the canonical example for parameter
block layout, debug flag usage, and keeping files thin and readable.

## Modeling conventions
- Put public parameters at the top of each `.scad` file with brief comments.
- Prefer simple CSG: union/difference/intersection.
- Prefer 2D profiles + linear_extrude() for prismatic parts.
- Avoid polyhedron() unless necessary (manifold pitfalls).
- Avoid minkowski() unless explicitly requested (performance).
- Remember: trig functions use degrees in OpenSCAD.

## Reusability
- Prefer flat file structures within each project.
- If code needs to be reused, extract it into another `.scad` module in the
  same project folder and `use <...>` it where needed.
- Only create a `lib/` folder when the level of indirection is clearly worth
  it and multiple modules truly need the same commonly reused logic.

## Debug / verification
- When helpful, include `debug=false` parameter.
- When `debug=true`, you may show:
  - axes and/or reference rulers
  - highlighted critical features using `#`
  - temporary cross-sections (projection(cut=true) or difference cuts)

## Assumptions
- If you must proceed with missing info, record assumptions in that project's
  `plan.md` under an "Assumptions" section.
- Do not backfill assumptions into `spec.md` without explicit approval.

## Deliverable checklist for a new part
- Parameters + defaults + comments
- Clear anchor/origin behavior (centered vs corner-based)
- Minimal, readable module structure
- A small set of render cases (if needed) noted in `plan.md`
