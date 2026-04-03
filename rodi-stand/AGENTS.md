# AGENTS.md

## Purpose
- Read `PROJECT.md` for project context and goals.
- Read `REQUIREMENTS.md` for the implementation contract.

## Source of truth
- `PROJECT.md` and `REQUIREMENTS.md` together define the project.
- If they conflict, `REQUIREMENTS.md` wins for implementation details.

## Working rules
- Keep top-level printable entrypoints in `models/`.
- Keep shared geometry in `lib/project/` when multiple entrypoints use it.
- Keep generated artifacts in `exports/`, not in `models/`.
- Preserve shared alignment assumptions such as mount width and screw spacing.
