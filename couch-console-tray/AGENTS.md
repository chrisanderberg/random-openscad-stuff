# AGENTS.md

## Purpose
- This file defines how agents should operate in this project.
- Read `PROJECT.md` for project context and measurement notes.
- Read `REQUIREMENTS.md` for the implementation contract.

## Source of truth
- `PROJECT.md` and `REQUIREMENTS.md` together are the effective project spec.
- If they conflict, `REQUIREMENTS.md` wins for implementation details and
  constraints.

## Working rules
- Do not silently violate hard requirements.
- Keep `models/` thin and put reusable geometry in `lib/project/` when it
  improves reuse or readability.
- Keep generated artifacts out of `models/`.
- Record inferred dimensions as estimates until they are confirmed with direct
  measurement.

## Definition of done
- The model renders in stable OpenSCAD without obvious geometry errors.
- Estimated dimensions taken from photos are clearly labeled as estimates.
