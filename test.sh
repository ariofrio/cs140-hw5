#!/bin/sh

one_test() {
  file=$1
  number=$2
  iters=$3
  echo -n "  $file: "

  n=$(wc -l $file)
  output=$(./life_debug r $n $iters < $file | ./validate $n $iters $number)
  if [ "$output" = "Result matched" ]; then
    tput setaf 2
    echo $output
    tput sgr0
  else
    tput setaf 1; tput bold
    echo $output
    tput sgr0
  fi
}

all_tests() {
  iters=$1
  echo
  tput setaf 8; echo -n "For ";
  tput setaf 7; tput bold; echo -n $iters;
  tput sgr0; tput setaf 8; echo " Iterations:"
  tput sgr0
  one_test input/input-0 0 $iters
  one_test input/input-1.1 1 $iters
  one_test input/input-1.2 1 $iters
  one_test input/input-1.3 1 $iters
  one_test input/input-1.4 1 $iters
  one_test input/input-2 2 $iters
}

all_tests 10
all_tests 1000
all_tests 9970

