# [go back to Overview](https://github.com/c4arl0s)

# [while - Content](https://github.com/c4arl0s/while#go-back-to-overview)

1. [x] [1. Arithmetic](https://github.com/c4arl0s/while#1-Arithmetic)
2. [x] [2. filesystem-related conditions](https://github.com/c4arl0s/while#2-filesystem-related-conditions)
3. [x] [3. or for reading input](https://github.com/c4arl0s/while#3-or-for-reading-input)
4. [x] [4. Elegant endless loop](https://github.com/c4arl0s/while#4-elegant-endless-loop)
5. [x] [5. Modify variable inside a while loop](https://github.com/c4arl0s/while#4-elegant-endless-loop)

# [while](https://github.com/c4arl0s/while#while---content)

# 1. [Arithmetic](https://github.com/c4arl0s/while#while---content)

```bash
while (( COUNT < MAX ))
do
    some stuff
    let COUNT++
done
```

# 2. [filesystem-related conditions](https://github.com/c4arl0s/while#while---content)

```bash
while [ -z "$LOCKFILE" ]
do
    some things
done
```

# 3. [or for reading input](https://github.com/c4arl0s/while#while---content)

You can pass standard output to these lines:

```bash
while read lineoftext
do
    process $lineoftext
done
```

# 4. [Elegant endless loop](https://github.com/c4arl0s/while#while---content)

Uff really elegant

```bash
while : ## Elegant Endless loop
do
    echo "Do something"
done
```

# 5. [Modify a variable inside a while loop]()

```bash
#/bin/bash

# Inside while loop will not be modified variable movie
echo "First time"
movie=""
echo ${movie}
cat movies.txt | cut -d "." -f 2 | while read movie_name; do
  if echo "${movie_name}" | grep "Kid"; then
    movie="${movie_name}"
  fi
done
echo "${movie}"

echo "Second time"
while IFS= read -r movie_name; do
  if echo "${movie_name}" | grep "Kid"; then
    movie="${movie_name}"
  fi
done < movies.txt

```

