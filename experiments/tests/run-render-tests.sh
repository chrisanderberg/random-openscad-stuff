#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
OPENSCAD="${OPENSCAD:-/opt/homebrew/bin/openscad}"

for src in "$ROOT"/models/*.scad; do
  name="$(basename "$src" .scad)"
  out="$ROOT/exports/validation-${name}.stl"
  if "$OPENSCAD" -o "$out" -q "$src" >/tmp/experiments-render.out 2>/tmp/experiments-render.err; then
    if [[ -s "$out" ]]; then
      echo "PASS $name"
    else
      echo "FAIL $name empty output"
      cat /tmp/experiments-render.err
      exit 1
    fi
  else
    echo "FAIL $name render error"
    cat /tmp/experiments-render.err
    exit 1
  fi
done
