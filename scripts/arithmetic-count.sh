#!/usr/bin/env bash
# Numeric while loop (Bash 3.2+). Run: /bin/bash scripts/arithmetic-count.sh
set -euo pipefail

COUNT=0
MAX=5
while (( COUNT < MAX )); do
  printf 'COUNT=%s\n' "$COUNT"
  COUNT=$((COUNT + 1))
done
echo "Done. Final COUNT=$COUNT"
