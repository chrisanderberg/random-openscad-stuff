# OpenSCAD Projects

This repository is a collection of small, focused OpenSCAD projects. Each
project lives in its own folder with its own `spec.md` and `plan.md`, allowing
simple one-off designs and multi-file efforts to coexist without a heavyweight
structure.

## Project Structure
- Root contains multiple project folders (e.g., `rodi-stand/`,
  `emersed-anubias-platforms/`, `floating-plant-rings/`, `paneled-cache-pot/`,
  `experiments/`).
- Each project folder typically includes:
  - `spec.md` with the project requirements and constraints.
  - `plan.md` with the implementation plan and assumptions.
  - One or more `.scad` files with the design modules.
  - Optional exported artifacts (`.stl`, `.3mf`).

## Conventions
- See `AGENTS.md` for workflow guidance.
- See `style-guide.md` for naming and coding conventions.
- Use `template.scad` at the repo root as the canonical example for layout and
  style.
