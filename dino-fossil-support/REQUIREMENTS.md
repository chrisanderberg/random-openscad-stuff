# REQUIREMENTS.md

## Hard requirements
- All dimensions shall be expressed in millimeters.
- The part shall be modeled as a single 2D profile and `linear_extrude()`'d.
- The first goal shall be matching the photographed silhouette as closely as
  practical from the provided references.
- The support shall remain a mostly straight constant-width strip with one
  shallow bend near one end.
- Both ends shall be visibly open forks in the outer silhouette.
- The model shall not add reinforcement features, gussets, ribs, spines,
  thickened elbows, decorative fillets, or other structural improvements.
- `models/` shall contain the top-level renderable `.scad` file.
- Generated meshes and renders shall not be committed under `models/`.

## Soft requirements
- Prefer matching the photos over adding inferred geometry.
- Prefer staying minimal and literal when a photographed detail is uncertain.
- Prefer explicit top-level parameters for key measured dimensions.
