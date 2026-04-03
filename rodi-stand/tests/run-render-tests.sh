#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
OPENSCAD="${OPENSCAD:-/opt/homebrew/bin/openscad}"

run() {
  local src="$1"
  local name
  name="$(basename "$src" .scad)"
  local out="$ROOT/exports/validation-${name}.stl"

  if "$OPENSCAD" -o "$out" -q "$src" >/tmp/rodi-stand-render.out 2>/tmp/rodi-stand-render.err; then
    if [[ -s "$out" ]]; then
      echo "PASS $name"
    else
      echo "FAIL $name empty output"
      cat /tmp/rodi-stand-render.err
      return 1
    fi
  else
    echo "FAIL $name render error"
    cat /tmp/rodi-stand-render.err
    return 1
  fi
}

run "$ROOT/models/stand.scad"
run "$ROOT/models/mount_ring.scad"
run "$ROOT/models/mount_plates.scad"
