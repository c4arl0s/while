#!/usr/bin/env bash
# Poll until a file appears (common macOS/Linux pattern). Run from repo root.
set -euo pipefail

READY="${TMPDIR:-/tmp}/while-demo-ready.$$"
rm -f "$READY"

(
  sleep 2
  printf 'ready\n' >"$READY"
) &

echo "Waiting for $READY ..."
while [[ ! -f "$READY" ]]; do
  sleep 1
  echo "  ...still waiting"
done

echo "Found: $READY"
cat "$READY"
rm -f "$READY"
