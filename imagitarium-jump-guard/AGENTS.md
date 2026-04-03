# AGENTS.md

## Purpose
- This file defines how agents should operate in this repository.
- Read `PROJECT.md` for project context and goals.
- Read `REQUIREMENTS.md` for the implementation contract.

## Source of truth
- `PROJECT.md` and `REQUIREMENTS.md` together are the effective project spec.
- If they conflict, `REQUIREMENTS.md` wins for implementation details and
  constraints.

## Working rules
- Do not silently violate hard requirements.
- Keep `models/gap_guard.scad` as the main tuning surface and keep reusable
  geometry in `lib/project/` when it improves clarity.
- Keep generated artifacts out of `models/`.
- Record durable fit or modeling guidance in `REQUIREMENTS.md`.
- Keep comments brief and focused on intent or geometric invariants.

## Definition of done
- The model renders in stable OpenSCAD without obvious geometry errors.
- Reusable guidance discovered during implementation is reflected in
  `REQUIREMENTS.md`.
