# PROJECT.md

## Overview
This project models a removable tray for a couch center console with two cup
holders in front of a lidded storage compartment.

The tray should:
- sit flat across the console top
- locate itself with two downward cone or frustum features that drop into the
  cup holders
- use a support lip around the underside perimeter
- include a rear support section that extends into the storage opening
- leave two gaps on the back lip where the console side walls interrupt the
  opening
- keep the rear support section thin enough that the existing lid can rest on
  it without requiring any latch feature
- sit flat over the console while clearing the raised cup-holder trim rings
  with underside relief pockets so only the locating plugs protrude downward

## Console interpretation
From the photos, the console appears to have:
- two identical metal-lined cup holders centered on the front panel
- a storage opening behind the cup holders with a recessed plastic bin
- a lid that simply rests flat when closed
- upholstered side bolsters that create two interrupted regions along the back
  support edge

## Estimated measurements from photos
These are first-pass estimates inferred from ruler photos, not confirmed direct
measurements.

- Cup holder inside diameter: about 88 mm
- Cup holder top opening or trim diameter: about 96 mm
- Cup holder center-to-center spacing: about 118 mm
- Clear gap between cup holder trim rings: about 22 mm
- Cup holder usable depth: about 64 mm
- Storage opening inside width: about 270 mm
- Tray overall width target: about 286 mm
- Tray overall front-to-back depth target: about 150 mm
- Cup holder center inset from tray front edge: about 72 mm
- Rear tongue into storage area: about 34 mm
- Rear tongue thickness target for lid support: about 1.8 mm

## Confirmed follow-up measurements
These values were refined after printing and checking fit on the actual couch
console.

- Cup holder plug top diameter fit: 90 mm
- Cup holder plug bottom diameter fit: 78 mm
- Cup holder plug height fit: 73 mm
- Cup holder rim width: 7.5 mm
- Cup holder rim height above surrounding surface: 5 mm
- Console width between side lips near the lip landing plane: 320 mm
- Side lip run from the front wrap toward the back: 170 mm

## Modeling approach
- Use a parameterized tray body with a shallow top pocket.
- Keep the top model in `models/` and reusable geometry in `lib/project/`.
- Keep dimension defaults centralized in `lib/project/params.scad`.
- Keep fit-validation prints in `fit-tests/` rather than mixing them into the
  final printable model directory.
- Treat all fit-critical measurements as parameters near the top of the model.
- Prefer a printable first prototype over overfitting to noisy photo
  perspective.

## Open questions
- Exact left-to-right tray width across the upholstered console top.
- Exact front-to-back position of the cup holder centers relative to the
  desired tray front edge.
- How the tray underside should clear or register against the 7.5 mm wide,
  5 mm tall cup-holder rim without rocking or over-constraining the fit.
- Whether the storage opening corners and wall draft require more chamfer or
  clearance on the rear tongue.
- How much load the rear lid-support section should safely carry in use.
