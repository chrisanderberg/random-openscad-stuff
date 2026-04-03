#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OPENSCAD_BIN="${OPENSCAD:-/opt/homebrew/bin/openscad}"
MODEL="$ROOT/models/lid_hole_jump_guard.scad"
OUTPUT_DIR="$ROOT/exports"

mkdir -p "$OUTPUT_DIR"

"$OPENSCAD_BIN" \
  -o "$OUTPUT_DIR/validation-lid_hole_jump_guard.stl" \
  --hardwarnings \
  --export-format binstl \
  "$MODEL"
