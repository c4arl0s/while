#!/usr/bin/env bash
# Poll until a child PID exits (while + kill -0). macOS /bin/bash compatible.
set -euo pipefail

sleep 3 &
pid=$!

echo "Watching PID $pid (sleeps 3s) ..."
while kill -0 "$pid" 2>/dev/null; do
  echo "  ...still running"
  sleep 1
done

echo "PID $pid has exited."
