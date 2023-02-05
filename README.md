# while

# Arithmetic

```bash
while (( COUNT < MAX ))
do
    some stuff
    let COUNT++
done
```

# filesystem-related conditions:

```bash
while [ -z "$LOCKFILE" ]
do
    some things
done
```

# or for reading input:

```bash
while read lineoftext
do
    process $lineoftext
done
```
