#!/usr/bin/env bash
# Classic argument parsing with while + shift (Bash 3.2+).
set -euo pipefail

verbose=0
out=""

usage() {
  echo "Usage: $0 [-v] [-o FILE] [--] [args...]" >&2
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -v)
      verbose=1
      shift
      ;;
    -o)
      [[ $# -lt 2 ]] && { echo "Missing value for -o" >&2; exit 1; }
      out="$2"
      shift 2
      ;;
    --)
      shift
      break
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      break
      ;;
  esac
done

echo "verbose=$verbose out=${out:-<none>}"
echo "Remaining args:" "$@"
