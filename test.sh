#!/bin/sh

one_test() {
  file=$1
  number=$2
  n=$(wc -l < $file)
  iters=$(( n * 5 ))

  printf "%-15s  " "$file"
  output=$(./life_debug r $n $iters < $file 2> /dev/null | ./validate $n $iters $number)
  if [ "$output" = "Result matched" ]; then
    tput setaf 2
    printf "%-20s" "$output"
    tput sgr0
  else
    tput setaf 1; tput bold
    printf "%-20s" "$output"
    tput sgr0
  fi
  tput setaf 8
  echo "    # ./life_debug r $n $iters < $file | ./validate $n $iters $number"
  tput sgr0
}

echo
one_test input/input-0 0
one_test input/input-1.1 1
one_test input/input-1.2 1
one_test input/input-1.3 1
one_test input/input-1.4 1
one_test input/input-2 2

