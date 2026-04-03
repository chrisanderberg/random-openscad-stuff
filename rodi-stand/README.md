# RO/DI Stand

A printable RO/DI stand project with supporting mount-ring and plate variants.

`models/` contains the printable entrypoints, `lib/project/` contains the
shared mount-ring module, and `exports/` contains copied STL and 3MF artifacts
from earlier iterations. Use `PROJECT.md` for context and `REQUIREMENTS.md` for
the implementation contract.

## Quick checks

- Render all top-level models with `tests/run-render-tests.sh`
- Override the OpenSCAD binary with `OPENSCAD=/path/to/OpenSCAD` if needed
