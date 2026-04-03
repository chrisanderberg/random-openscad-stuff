# AGENTS.md

## Purpose
- Read `PROJECT.md` for project context and goals.
- Read `REQUIREMENTS.md` for the implementation contract.

## Source of truth
- `PROJECT.md` and `REQUIREMENTS.md` together define the project.
- If they conflict, `REQUIREMENTS.md` wins for implementation details.

## Working rules
- Keep generated artifacts in `exports/`, not in `models/`.
- Keep fit-sensitive dimensions and container-specific assumptions explicit.
- Prefer reusable geometry patterns only when they actually reduce duplication.
