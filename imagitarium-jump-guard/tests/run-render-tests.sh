#!/usr/bin/env bash
# Run render-matrix cases via OpenSCAD CLI.
# Requires OpenSCAD on PATH or OPENSCAD set to app-bundle binary (e.g. on macOS).

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
MODEL="$ROOT/models/gap_guard.scad"
EXPORTS="$ROOT/exports"
OPENSCAD="${OPENSCAD:-/Applications/OpenSCAD-2021.01.app/Contents/MacOS/OpenSCAD}"

mkdir -p "$EXPORTS"
FAILED=0
PASSED=0

run() {
  local name="$1"
  shift
  local out="$EXPORTS/test-${name}.stl"
  if "$OPENSCAD" -o "$out" -q "$@" "$MODEL" 2>/dev/null; then
    if [[ -s "$out" ]]; then
      echo "PASS  $name"
      ((PASSED++)) || true
    else
      echo "FAIL  $name (empty output)"
      ((FAILED++)) || true
    fi
  else
    echo "FAIL  $name (render error)"
    ((FAILED++)) || true
  fi
}

echo "Render matrix: $MODEL"
echo "---"

# Default (use current defaults in models/gap_guard.scad)
run "default"

# clip_clearance
for c in 0.2 0.4 0.6; do
  run "clip_clearance-${c}" -D "clip_clearance=$c"
done

# wall_t
for w in 1.2 1.6 2.4; do
  run "wall_t-${w}" -D "wall_t=$w"
done

# gap_depth with tongue_margin fixed at 2.0
for g in 25 29 33; do
  run "gap_depth-${g}" -D "gap_depth=$g" -D 'tongue_margin=2.0'
done

echo "---"
echo "Passed: $PASSED  Failed: $FAILED"
[[ $FAILED -eq 0 ]]
