# Style Guide (OpenSCAD Projects)

## File naming
- Markdown: kebab-case (e.g., `style-guide.md`, `render-notes.md`).
- OpenSCAD: snake_case (e.g., `mount_ring.scad`, `platform_utils.scad`).
- Exception: `AGENTS.md` stays uppercase.

## Structure
- Prefer flat file structures within each project folder.
- If code needs to be reused, extract it into another `.scad` module in the
  same folder and `use <...>` it from other files.
- Only create a `lib/` folder when the level of indirection is clearly worth
  it and multiple modules truly need the same commonly reused logic.

## Parameters and layout
- Put public parameters at the top of each `.scad` file with brief comments.
- Group sections with headers:
  - `// ---------- Public parameters (mm) ----------`
  - `// ---------- Resolution ----------`
  - `// ---------- Derived ----------`
- Keep derived values below the public parameter block.

## Naming (in code)
- Use snake_case for variables, parameters, functions, and modules.
- Suffixes:
  - `*_d` diameter, `*_r` radius, `*_h` height, `*_w` width, `*_t` thickness.
- Modules: nouns (e.g., `mount_plate()`).
- Functions: value-returning names (e.g., `hole_positions()`).

## Units and orientation
- mm.
- Z up.
- Prefer centered geometry for reusable modules unless there’s a strong reason
  not to; always document anchor/origin behavior.

## Performance defaults
- Use a reasonable `$fn`; expose it when surface quality matters.
- Avoid expensive operations by default (`minkowski`, heavy `hull` usage).

## Debug conventions
- Add `debug = false` when it’s useful.
- Use:
  - `#` to highlight
  - `%` for transparent reference geometry
  - `*` to disable blocks during iteration

## Comment style
- Sentence case with trailing periods.
- Prefer short, descriptive comments over redundant ones.
