#include <stdio.h>
// a = 7, m = 32767, seed = 100
int * random (int seed, int size){
	int a,x,m,q,r, i;
	a = size;
	m = 32767;
	x = seed;
	q = m / a;
	r = m % a;
	for (i = 0; i <= 20; i++){
		x = a * (x%q) - r * (x/q);
		if (x < 0)
			x = x + m;
		printf("%x\n",x);
	}
	
}

int main(){
	int size = 7;
	int seed = 10;
	random(seed,size);
}
