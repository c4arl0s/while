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

