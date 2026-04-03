# PROJECT.md

## Overview
This project models a printable portable stand and mounting system for an RO/DI
water filter unit. It includes the base stand, a mount ring, and separate mount
plates that extend the effective mounting height.

## Current shape
- `models/stand.scad` is the main stand source.
- `models/mount_ring.scad` and `models/mount_plates.scad` are separate printable
  entrypoints.
- `lib/project/mount_ring_module.scad` contains shared mount-ring geometry.
- Existing STL and 3MF artifacts from the older workspace were copied into
  `exports/`.

## Design notes
- The stand, ring, and plates share alignment assumptions such as mounting
  width and screw spacing.
- This migration translates the old flat layout into the newer structure
  without changing the actual modeled design.
