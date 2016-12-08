/* 	
*	Class: CSE 313 Machine Organization Lab
*	Term: Fall 2016
*	Name(s): Steven Tang and Andrew Hedy
*	Group 9
*	Extra Credit Lab 9
*	Description: In this lab, we're implementing the LCRNG algorithm in C to
*	generate random numbers. We're going to generate 20 random numbers and 
*	output them to the screen.
*	a = 7, m = 32767, seed = 100
*/
#include <stdio.h>

int * random (int seed, int size){
	int a,x,m,q,r,i;
	a = 7;
	m = 32767;
	x = seed;
	q = m / a;
	r = m % a;
	for (i = 0; i < size; i++){
		x = a * (x%q) - r * (x/q);
		if (x < 0)
			x = x + m;
		printf("%d\n",x);
	}
	return 0;
}

int main(){
	int size,seed;
	printf("\nPlease enter the size:\n");
	scanf("%i",&size);
	printf("Please enter the seed:\n");
	scanf("%i",&seed);
	printf("\nYour ");
	printf("%i",size);
	printf(" random numbers are:\n");
	random(seed,size);
}
