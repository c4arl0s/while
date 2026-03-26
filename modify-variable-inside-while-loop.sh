#!/usr/bin/env bash
# Pipeline runs the while body in a subshell — outer 'movie' stays empty.
# Reading from a file with 'done < file' updates the parent shell variable.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
MOVIES="$ROOT/movies.txt"

echo "First time (pipeline / subshell — movie not kept in parent)"
movie=""
echo "${movie}"
cut -d '.' -f 2 "$MOVIES" | while IFS= read -r movie_name || [[ -n "$movie_name" ]]; do
  [[ -z "$movie_name" ]] && continue
  title="${movie_name# }"
  case "$title" in
    *Kid*) movie="$title" ;;
  esac
done
echo "${movie}"

echo ""
echo "Second time (redirect — movie updates in parent shell)"
movie=""
while IFS= read -r movie_name || [[ -n "$movie_name" ]]; do
  [[ -z "$movie_name" ]] && continue
  title="${movie_name#*. }"
  case "$title" in
    *Kid*) movie="$title" ;;
  esac
done <"$MOVIES"
echo "${movie}"
