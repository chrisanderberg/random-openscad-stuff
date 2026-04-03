# OpenSCAD Starter Template

An OpenSCAD starter template for small printable parts, organized around a
minimal instruction model instead of a large stack of planning documents.

## Template approach

- `PROJECT.md` holds context, intent, and notes that do not belong in the
  implementation contract.
- `REQUIREMENTS.md` holds hard and soft requirements for the part.
- `AGENTS.md` tells coding agents to read those files and keep changes aligned
  with them.

This template is aimed at small OpenSCAD repos where a separate spec, plan,
style guide, and API reference would be more process than product.

## Using this template

If you use [BOOTSTRAP.md](BOOTSTRAP.md), it creates the minimal repo structure.
If you clone this repo directly, replace `README.md`, `PROJECT.md`,
`REQUIREMENTS.md`, and `LICENSE` with project-specific content.

### One-command bootstrap

Create a new project by copying this template without its Git history:

```bash
/Users/christopheranderberg/projects/3Dmodels/openscad-starter-template/scripts/bootstrap-new-project.sh \
  /Users/christopheranderberg/projects/3Dmodels/my-new-project \
  --git
```

Omit `--git` if you want to copy the files first and initialize Git yourself.

## Vendored libraries and licensing

The template includes `lib/vendor/` for third-party OpenSCAD libraries.
Adding vendored libraries may constrain your project license, so check each
library's license before deciding what your repo should use.

## Project layout

- `PROJECT.md` for project context and goals
- `REQUIREMENTS.md` for hard and soft requirements
- `lib/project/` for reusable OpenSCAD modules
- `models/` for top-level renderable variants
- `tests/` for render cases and validation notes
- `exports/` for generated artifacts

## Getting started

Fill in `PROJECT.md` and `REQUIREMENTS.md`, then implement under `lib/project/`
and `models/`.
