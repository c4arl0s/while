#!/usr/bin/env bash
# while : with a break so the demo terminates. Run: /bin/bash scripts/endless-with-break.sh
set -euo pipefail

i=0
while :; do
  ((i++)) || true
  printf 'tick %s\n' "$i"
  if (( i >= 3 )); then
    echo "Breaking out of while :"
    break
  fi
  sleep 1
done
