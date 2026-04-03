# 3D Models

This repository is a collection of small OpenSCAD projects. Most of the
projects are one-off printable parts, so each project keeps its own local docs
and source tree inside a single shared repo.

## Projects

- `imagitarium-jump-guard/`: rear gap guard for a shallow Imagitarium tank
- `imagitarium-lid-hole-jump-guard/`: guard for a feeder or access hole in an
  Imagitarium lid
- `aquarium-floating-plant-rings/`: floating plant ring variants
- `emersed-plant-platforms/`: emersed plant platforms for different containers
- `paneled-cache-pot/`: decorative cache pot and panel variants
- `rodi-stand/`: utility stand and mount ring parts
- `experiments/`: scratchpad and exploratory models
- `openscad-starter-template/`: starter template for new OpenSCAD projects

## Working model

- Treat each project directory as a self-contained OpenSCAD project.
- Read that project's `PROJECT.md` and `REQUIREMENTS.md` before editing it.
- Keep generated meshes inside that project's `exports/` directory.
- Only extract shared code when multiple projects actually start using the same
  geometry or conventions.
