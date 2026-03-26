# [go back to Overview](https://github.com/c4arl0s)

# [while - Content](https://github.com/c4arl0s/while#go-back-to-overview)

1. [x] [1. Arithmetic](https://github.com/c4arl0s/while#1-arithmetic)
2. [x] [2. Filesystem-related conditions](https://github.com/c4arl0s/while#2-filesystem-related-conditions)
3. [x] [3. Reading input](https://github.com/c4arl0s/while#3-reading-input)
4. [x] [4. Elegant endless loop](https://github.com/c4arl0s/while#4-elegant-endless-loop)
5. [x] [5. Modify variable inside a while loop](https://github.com/c4arl0s/while#5-modify-variable-inside-a-while-loop)
6. [x] [6. More patterns & example scripts](https://github.com/c4arl0s/while#6-more-patterns--example-scripts)

# [while](https://github.com/c4arl0s/while#while---content)

## macOS and Bash

On macOS, **`/bin/bash` is GNU Bash 3.2** (the default login shell for many accounts is **zsh**, but these snippets are **bash**). If you use a newer Bash from [Homebrew](https://brew.sh/), run scripts explicitly with `bash script.sh` or point your shebang at that interpreter.

All examples below are written to work on **Bash 3.2 and newer** (including the Bash 5.x builds common on Apple Silicon Homebrew setups).

---

## 1. Arithmetic

C-style arithmetic in `(( ... ))` is clear for numeric loops:

```bash
#!/usr/bin/env bash
COUNT=0
MAX=5
while (( COUNT < MAX )); do
  printf 'COUNT=%s\n' "$COUNT"
  ((COUNT++))
done
```

Runnable demo: [`scripts/arithmetic-count.sh`](scripts/arithmetic-count.sh)

---

## 2. Filesystem-related conditions

Test paths with `[` / `[[`**.** A common pattern is to wait until another process creates a file, or to pause while a lock file exists:

```bash
#!/usr/bin/env bash
READY_FILE="${TMPDIR:-/tmp}/myapp.ready"

# Wait until a sentinel file appears
while [[ ! -f "$READY_FILE" ]]; do
  sleep 1
done
echo "Ready: $READY_FILE exists"
```

```bash
#!/usr/bin/env bash
LOCKFILE="/tmp/myapp.lock"

# Hold off while another job owns the lock file
while [[ -f "$LOCKFILE" ]]; do
  sleep 1
done
```

**Note:** The old snippet `while [ -z "$LOCKFILE" ]` loops while the **variable is empty**, not while a path is missing on disk. For filesystem work, prefer `-f`, `-d`, `-e`, etc., on a **non-empty** path.

Runnable demo: [`scripts/wait-for-file.sh`](scripts/wait-for-file.sh)

---

## 3. Reading input

Read lines from stdin. Use **`-r`** (raw) so backslashes are not interpreted, and **quote** the line variable so spaces and glob characters are safe:

```bash
#!/usr/bin/env bash
while IFS= read -r line; do
  printf 'Line: %s\n' "$line"
done < somefile.txt
```

Process substitution also works on Bash (including macOS `/bin/bash` 3.2):

```bash
#!/usr/bin/env bash
while IFS= read -r line; do
  printf 'Line: %s\n' "$line"
done < <(grep -v '^#' config.txt)
```

Runnable demo: [`scripts/read-lines.sh`](scripts/read-lines.sh)

---

## 4. Elegant endless loop

`:` is a built-in that does nothing and exits true—handy for `while :`:

```bash
#!/usr/bin/env bash
while :; do
  echo "Do something"
  sleep 2
done
```

For a real service loop you usually add `sleep`, `break`, or `exit` on signals. See [`scripts/endless-with-break.sh`](scripts/endless-with-break.sh) for a safe demo that stops after a few iterations.

---

## 5. Modify variable inside a while loop

A **pipeline** runs the right-hand side in a **subshell**. Assignments to variables there do not affect the parent shell—this catches many people:

```bash
#!/usr/bin/env bash
# Wrong for updating 'movie' in the parent shell:
movie=""
cut -d '.' -f 2 movies.txt | while IFS= read -r movie_name; do
  case "$movie_name" in
    *Kid*) movie="${movie_name# }" ;;  # trim leading space from cut
  esac
done
echo "After pipe loop: '${movie}'"   # still empty
```

**Fix:** redirect into `while` instead of piping, or use process substitution so the loop runs in the current shell:

```bash
#!/usr/bin/env bash
movie=""
while IFS= read -r line; do
  movie_name="${line#*. }"   # drop leading "123. "
  case "$movie_name" in
    *Kid*) movie="$movie_name" ;;
  esac
done < movies.txt
echo "After while-read redirect: '$movie'"
```

Runnable demo: [`scripts/modify-variable-subshell-demo.sh`](scripts/modify-variable-subshell-demo.sh) (also kept at repo root as [`modify-variable-inside-while-loop.sh`](modify-variable-inside-while-loop.sh)).

---

## 6. More patterns & example scripts

| Script | Idea |
|--------|------|
| [`scripts/arithmetic-count.sh`](scripts/arithmetic-count.sh) | Numeric `while (( ... ))` |
| [`scripts/wait-for-file.sh`](scripts/wait-for-file.sh) | Poll until a file exists |
| [`scripts/read-lines.sh`](scripts/read-lines.sh) | `while read -r` over `movies.txt` |
| [`scripts/endless-with-break.sh`](scripts/endless-with-break.sh) | `while :` with `break` |
| [`scripts/read-flags-while.sh`](scripts/read-flags-while.sh) | Parse `$@` with `while` + `shift` |
| [`scripts/process-monitor.sh`](scripts/process-monitor.sh) | Poll until a PID disappears |
| [`scripts/modify-variable-subshell-demo.sh`](scripts/modify-variable-subshell-demo.sh) | Subshell vs parent-shell assignment |

From the repo root:

```bash
/bin/bash scripts/arithmetic-count.sh
/bin/bash scripts/wait-for-file.sh
/bin/bash scripts/read-lines.sh
/bin/bash scripts/endless-with-break.sh
/bin/bash scripts/read-flags-while.sh
/bin/bash scripts/process-monitor.sh
/bin/bash scripts/modify-variable-subshell-demo.sh
```

These commands use the **system Bash on macOS** (`/bin/bash`, 3.2.x). If your `bash` on `PATH` is newer, `bash scripts/...` is fine too.
