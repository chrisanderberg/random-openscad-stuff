# AGENTS.md

## Purpose
- This file defines how agents should operate in this project.
- Read `PROJECT.md` for project context and goals.
- Read `REQUIREMENTS.md` for the implementation contract.

## Source of truth
- `PROJECT.md` and `REQUIREMENTS.md` together are the effective project spec.
- If they conflict, `REQUIREMENTS.md` wins for implementation details and
  constraints.

## Working rules
- Do not silently violate hard requirements.
- If something important is missing, record the narrowest safe assumption in
  `PROJECT.md` or `REQUIREMENTS.md`.
- Keep `models/` thin and put reusable geometry in `lib/project/` when it
  improves reuse or readability.
- Keep generated artifacts out of `models/`.
- Add brief comments only where intent or geometric invariants are not obvious.

## Definition of done
- The model renders in stable OpenSCAD without obvious geometry errors.
- Fit-critical parameters are easy to find and tune.
