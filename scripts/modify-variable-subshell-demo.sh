#!/usr/bin/env bash
# Pipe to while runs in a subshell: parent 'movie' never updates.
# Redirecting with 'done < file' runs in the current shell.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
MOVIES="$ROOT/movies.txt"

echo "=== First time (pipeline: while runs in a subshell) ==="
movie=""
cut -d '.' -f 2 "$MOVIES" | while IFS= read -r line || [[ -n "$line" ]]; do
  [[ -z "$line" ]] && continue
  title="${line# }"
  case "$title" in
    *Kid*) movie="$title" ;;
  esac
done

echo "movie='${movie}'"

echo ""
echo "=== Second time (redirect into while: updates outer movie) ==="
movie=""
while IFS= read -r line || [[ -n "$line" ]]; do
  [[ -z "$line" ]] && continue
  title="${line#*. }"
  case "$title" in
    *Kid*) movie="$title" ;;
  esac
done <"$MOVIES"

echo "movie='${movie}'"
