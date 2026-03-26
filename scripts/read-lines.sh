#!/usr/bin/env bash
# Read lines with while + read -r (safe for spaces). Run from repo root.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
FILE="$ROOT/movies.txt"

n=0
while IFS= read -r line || [[ -n "$line" ]]; do
  [[ -z "$line" ]] && continue
  n=$((n + 1))
  if (( n <= 3 )); then
    printf 'Movie line %s: %s\n' "$n" "$line"
  fi
done <"$FILE"

echo "(Showing first 3 lines of movies.txt; total lines read: $n)"
