#!/usr/bin/env bash
set -u

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

to_posix_path() {
  if command -v cygpath >/dev/null 2>&1; then
    cygpath -u "$1" 2>/dev/null || printf '%s\n' "$1"
  else
    printf '%s\n' "$1"
  fi
}

if [ -n "${CODEX_HOME:-}" ]; then
  DEST_DIR="$(to_posix_path "$CODEX_HOME")/skills"
else
  DEST_DIR="$(to_posix_path "$HOME")/.codex/skills"
fi

mkdir -p "$DEST_DIR"

echo "Installing Codex skills from: $ROOT_DIR"
echo "Destination: $DEST_DIR"
echo

installed=0
skipped=0
pending=0
failed=0

for skill_dir in "$ROOT_DIR"/*; do
  [ -d "$skill_dir" ] || continue

  name="$(basename "$skill_dir")"
  [ "$name" = ".git" ] && continue

  if [ ! -f "$skill_dir/SKILL.md" ]; then
    echo "PENDING  $name: no SKILL.md found; not installed"
    pending=$((pending + 1))
    continue
  fi

  dest="$DEST_DIR/$name"

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    echo "SKIP     $name: destination already exists"
    skipped=$((skipped + 1))
    continue
  fi

  if ln -s "$skill_dir" "$dest"; then
    echo "LINK     $name -> $dest"
    installed=$((installed + 1))
  else
    echo "FAILED   $name: symlink failed"
    failed=$((failed + 1))
  fi
done

echo
echo "Install summary: linked=$installed skipped=$skipped pending=$pending failed=$failed"

if [ "$failed" -gt 0 ]; then
  exit 1
fi

