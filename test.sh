#!/bin/sh
ret=0

header() {
  echo
  tput setaf 8
  echo "$@"
  tput sgr0
}

one_test() {
  file=$1
  number=$2
  n=$(wc -l < $file)
  iters=$(( n * 5 ))

  printf "  %-15s  " "$file"
  output=$(./life_debug r $n $iters < $file 2> /dev/null | ./validate $n $iters $number)
  if [ "$output" = "Result matched" ]; then
    tput setaf 2
    printf "%-20s" "$output"
    tput sgr0
  else
    tput setaf 1; tput bold
    printf "%-20s" "$output"
    tput sgr0
    ret=1
  fi
  tput setaf 8
  echo "    # ./life_debug r $n $iters < $file | ./validate $n $iters $number"
  tput sgr0
}

header "Correctness:"
one_test input/input-0 0
one_test input/input-1.1 1
one_test input/input-1.2 1
one_test input/input-1.3 1
one_test input/input-1.4 1
one_test input/input-2 2

sum=0.0
count=0
one_bench() {
  file=$1
  n=$(wc -l < $file)
  iters=$(( 100000 / n ))
  printf "  %-15s  " "$file"

  output=$(./life r $n $iters < $file)
  printf "%-20s" "$output"
  sum=$(echo "$sum + $output" | bc)
  count=$(( count + 1 ))

  tput setaf 8
  echo "    # ./life r $n $iters < $file"
  tput sgr0
}

header "Benchmarks:"
for i in input/*; do
  one_bench $i
done

average=$(echo "scale=6; $sum / $count" | bc)
saved_average=$(git show HEAD:last_benchmark_average 2> /dev/null)
tput setaf 8
echo "  ---------------------------"
echo -n "  average          "
tput sgr0
if [ -z $saved_average ]; then
  tput setaf 2
  echo "$average"
else
  approx_equals=$(echo "$average - $saved_average < $average*0.05 && $average - $saved_average > -$average*0.05" | bc)
  if [ $approx_equals -eq 1 ]; then
    operator="≈"
    tput setaf 2
  elif [ $(echo "scale=6; $average < $saved_average" | bc) -eq 1 ]; then
    operator="<"
    tput setaf 2
  else
    operator=">"
    tput setaf 1
    tput bold
    ret=1
    echo $average > last_benchmark_average
  fi
  echo -n "$average $operator $saved_average"
  tput sgr0
fi
echo

exit $ret

