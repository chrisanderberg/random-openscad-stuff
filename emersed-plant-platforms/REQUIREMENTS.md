# REQUIREMENTS.md

## Hard requirements
- All dimensions shall use millimeters.
- Models shall render in stable OpenSCAD without intentional self-intersections
  or zero-thickness geometry.
- The platform shall provide a solid rim and an open interior for roots and
  water flow.
- Container-specific source files shall remain in `models/`.
- Generated meshes shall be written to `exports/`.

## Soft requirements
- Prefer keeping container-specific variants as thin wrappers over shared
  geometry if this project is refactored later.
- Prefer support-free geometry in the default print orientation.
- Prefer documenting container assumptions in code comments or requirements
  rather than burying them in ad hoc parameter choices.

## Open questions
- If this project is revived, the shared geometry should likely be extracted
  into `lib/project/` instead of remaining split across standalone variants.
