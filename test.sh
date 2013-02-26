#!/bin/sh
iters=1000

one_test() {
  file=$1
  number=$2
  echo -n "$file: "

  n=$(wc -l $file)
  output=$(./life_debug r $n $iters < $file | ./validate $n $iters $number)
  if [ "$output" = "Result matched" ]; then
    echo $output
  else
    tput setaf 1; tput bold
    echo $output
    tput sgr0
  fi
}

one_test input/input-0 0
one_test input/input-1.1 1
one_test input/input-1.2 1
one_test input/input-1.3 1
one_test input/input-1.4 1
one_test input/input-2 2

