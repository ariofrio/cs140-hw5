all: life life_debug validate 

life_debug: life.cpp submit.cpp 
	cilk++ -DDEBUG=1 -fcilkscreen -o life_debug life.cpp submit.cpp 

life: life.cpp submit.cpp
	cilk++ -DDEBUG=0 -fcilkscreen -o life life.cpp submit.cpp 

validate: validate.cpp
	g++ -o validate validate.cpp	
clean: 
	rm life life_debug validate
