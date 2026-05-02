# PROJECT.md

## Overview
This project models a small reusable plug for a Bic mechanical pencil eraser
opening so the pencil can be refilled while still accepting a Pentel Hi-Polymer
eraser cap.

The plug replaces the stock disposable eraser with a printable insert. Two
variants are useful:
- A simple cylindrical plug that matches the original eraser diameter.
- A stepped plug with an insert diameter sized like the eraser and a wider head
  diameter sized like the outer pencil top.

## Goals
- Keep the model extremely simple and easy to adjust from physical
  measurements.
- Provide printable variants for both the single-diameter and stepped designs.
- Expose fit-related dimensions near the top-level entrypoints.

## Notes
- Measured baseline dimensions:
  insert diameter 6.4 mm, head diameter 8.0 mm, insert section height 6.0 mm,
  head section height 6.0 mm.
- The simple variant uses the same overall 12.0 mm height as the stepped
  variant unless changed for fit tuning.
