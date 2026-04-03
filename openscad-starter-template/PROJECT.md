# PROJECT.md

## Overview
This repository is a minimal OpenSCAD project template for small printable
parts. It is intended for projects where the codebase should stay easy to scan
and the documentation should stay proportional to the physical part being
designed.

The template assumes a simple split:
- `PROJECT.md` captures project context, goals, and notes that do not belong in
  requirements.
- `REQUIREMENTS.md` captures the active implementation contract using hard and
  soft requirements.
- `AGENTS.md` tells coding agents how to use those files.

## Goals
- Keep small OpenSCAD projects lightweight and reviewable.
- Separate durable constraints from general context.
- Encourage reusable geometry in `lib/project/` while keeping `models/` as thin
  entrypoints.
- Keep generated artifacts out of source directories.

## Recommended repo shape
- `README.md` for public-facing summary and quick start.
- `PROJECT.md` for intent, context, tradeoffs, and open notes.
- `REQUIREMENTS.md` for hard and soft requirements.
- `AGENTS.md` for minimal agent workflow instructions.
- `lib/project/` for reusable OpenSCAD modules.
- `models/` for top-level printable variants.
- `tests/` for a render matrix or lightweight validation script.
- `exports/` for generated meshes and renders.

## Scope guidance
- Keep this file stable and high-level.
- Do not turn this file into a task log.
- Put binding constraints in `REQUIREMENTS.md`, not here.
