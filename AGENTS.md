# AGENTS.md

## Purpose
- This repository contains multiple independent OpenSCAD projects.
- Work in one project directory at a time.
- Read that project's `PROJECT.md` and `REQUIREMENTS.md` before making changes.

## Workspace guidance
- For focused modeling work, it is reasonable to open a single project
  subdirectory as the workspace.
- Use the repository root as the workspace when doing cross-project cleanup,
  reorganization, or repository-wide Git operations.

## Source of truth
- Do not invent repository-wide product requirements.
- The active source of truth lives inside the specific project being edited.
- If a project's `PROJECT.md` and `REQUIREMENTS.md` conflict,
  `REQUIREMENTS.md` wins for implementation details and constraints.

## Working rules
- Keep generated meshes out of `models/`.
- Keep `models/` as top-level entrypoints and move reusable geometry into
  `lib/project/` when it improves readability or reuse within that project.
- Keep root-level docs light. Shared guidance belongs here only if it genuinely
  applies across multiple projects.
