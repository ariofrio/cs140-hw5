#include<cilk.h>
#include<iostream>
#include<string.h>
#include<stdio.h>
#include<stdlib.h>
#include<numeric>
#include<sys/time.h>

void readlife(int *a,unsigned int n);
void genlife(int *a,unsigned int n);
void life(int *a,unsigned int n, unsigned int iter);
int countlive(int *a, unsigned int n);
