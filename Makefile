all: life life_debug life_output validate

life_debug: life.cpp submit.cpp
	cilk++ -DDEBUG=1 -DOUTPUT=0 -fcilkscreen -o life_debug life.cpp submit.cpp

life_output: life.cpp submit.cpp
	cilk++ -DDEBUG=0 -DOUTPUT=1 -fcilkscreen -o life_output life.cpp submit.cpp

life: life.cpp submit.cpp
	cilk++ -DDEBUG=0 -DOUTPUT=0 -fcilkscreen -o life life.cpp submit.cpp

validate: validate.cpp
	g++ -o validate validate.cpp

clean:
	rm life life_debug life_output validate

.DEFAULT_GOAL=test
test: all
	./test.sh

sync:
	while true; do rsync --archive . triton:hw5; rsync --archive triton:hw5/last_benchmark_average last_benchmark_average; sleep 0.1; done
