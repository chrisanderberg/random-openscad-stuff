# AGENTS.md

## Purpose
- Read `PROJECT.md` for project context and goals.
- Read `REQUIREMENTS.md` for the implementation contract.

## Source of truth
- `PROJECT.md` and `REQUIREMENTS.md` together define the project.
- If they conflict, `REQUIREMENTS.md` wins for implementation details.

## Working rules
- Keep experiments isolated from production designs.
- Keep generated artifacts in `exports/`.
- Prefer short-lived, focused test models over turning this directory into a
  second archive.
