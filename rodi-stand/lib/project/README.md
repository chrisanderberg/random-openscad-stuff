# lib/project

Shared geometry used by multiple top-level printable entrypoints lives here.

At the moment:
- `mount_ring_module.scad` contains the shared mount-ring geometry used by
  `models/stand.scad` and `models/mount_ring.scad`.

Keep this folder small and only move code here when the reuse is real.
