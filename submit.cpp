/*
Homework 5 : The Game of Life.
Team member 1 : John Doe 
Team member 2 : Jane Doe
*/

#include "life.h"
extern int *livecount;

#define xy(i, j)    (i*n + j)
#define xymod(i, j) (mod(i, n)*n + mod(j, n))
#define mod(x, y)   ((x%y)+y)%y

//Generate the life matrix any way you want. We would highly recommend that you print the generated
//matrix into a file, so that you can share it with other teams for checking correctness.
void genlife(int *a, unsigned int n)
{
	srand(235178);
  for(int i=0; i<n*n; i++) {
    a[i] = (rand() % 5) > 0; // 0 => 0; (1, 2, 3, 4) => 1
  }
}

//Read the life matrix from a file
void readlife(int *a, unsigned int n)
{
  for(int i=0; i<n*n; i++) {
    std::cin >> a[i];
  }
}

//Life function
void life(int *a, unsigned int n, unsigned int iters)
{
  int *neighbors = (int *)malloc(sizeof(int)*(n*n));
  for(int iter; iter<iters; iter++) {
    cilk_for(int i=0; i<n; i++) {
      cilk_for(int j=0; j<n; j++) {
        neighbors[xy(i, j)] = a[xymod(i-1, j)]   + a[xymod(i+1, j)]
                            + a[xymod(i,   j-1)] + a[xymod(i,   j+1)]
                            + a[xymod(i-1, j-1)] + a[xymod(i+1, j+1)]
                            + a[xymod(i+1, j-1)] + a[xymod(i-1, j+1)];
      }
    }
    cilk_for(int i=0; i<n; i++) {
      cilk_for(int j=0; j<n; j++) {
        int ij = xy(i, j);
        a[ij] = (a[ij] == 1 && neighbors[ij] == 2) || neighbors[ij] == 3;
      }
    }
    // TODO: Break nested loops into single loops, give Cilk more control
    // over parallelization (does not have to wait for row to be done before
    // starting next).

#if DEBUG == 1
    int every = iters/10;
    if((iter+1) % every == 0) {
      livecount[(iter+1)/every - 1] = countlive(a, n);
    }
#endif
    
  }

	// You need to store the total number of livecounts for every 1/10th of the total iterations into the livecount array. 
	// For example, if there are 50 iterations in your code, you need to store the livecount for iteration number 5 10 15 
	// 20 ... 50. The countlive function is defined in life.cpp, which you can use. Note that you can
	// do the debugging only if the number of iterations is a multiple of 10.
	// Furthermore, you will need to wrap your counting code inside the wrapper #if DEBUG == 1 .. #endif to remove
	// it during performance evaluation.
	// For example, your code in this function could look like - 
	//
	//
	//	for(each iteration)
	//      {
	//			
	//		Calculate_next_life();
	//		
	//		#if DEBUG == 1
	//		  if_current_iteration == debug_iteration
	//		  total_lives = countlive();
	//		  Store_into_livecount(total_lives);
	//		#ENDIF
	//		
	//	}
	
}
