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

  if "$OPENSCAD" -o "$out" -q "$src" >/tmp/floating-render.out 2>/tmp/floating-render.err; then
    if [[ -s "$out" ]]; then
      echo "PASS $name"
    else
      echo "FAIL $name empty output"
      cat /tmp/floating-render.err
      return 1
    fi
  else
    echo "FAIL $name render error"
    cat /tmp/floating-render.err
    return 1
  fi
}

for src in "$ROOT"/models/*.scad; do
  run "$src"
done
