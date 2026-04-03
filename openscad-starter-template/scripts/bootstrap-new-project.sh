#!/usr/bin/env bash

set -euo pipefail

if [[ $# -lt 1 || $# -gt 2 ]]; then
  echo "Usage: $(basename "$0") <new-project-path> [--git]"
  exit 1
fi

SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET_DIR="$1"
INIT_GIT="${2:-}"

if [[ -e "$TARGET_DIR" ]]; then
  echo "Target already exists: $TARGET_DIR"
  exit 1
fi

mkdir -p "$TARGET_DIR"

rsync -a \
  --exclude '.git' \
  --exclude '.DS_Store' \
  "$SOURCE_DIR/" "$TARGET_DIR/"

if [[ "$INIT_GIT" == "--git" ]]; then
  git -C "$TARGET_DIR" init >/dev/null
fi

cat <<EOF
Created new project at:
  $TARGET_DIR

Next steps:
  1. Replace README.md with a project-specific summary.
  2. Fill in PROJECT.md.
  3. Fill in REQUIREMENTS.md.
  4. Rename or add model files under models/.
EOF
