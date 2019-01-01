#include<iostream>
#include<cmath>
#include<vector>
#include<cstdlib>
#include"interp.h"

constexpr int N = 19;
const double PI = acos(-1.0);

void generateSin(std::vector<double> &xs, std::vector<double> &ys, unsigned long n){
	for(unsigned long i = 0; i < n; i++){
		xs[i] = 2 * PI / n * i;
		ys[i] = sin(xs[i]);
	}
}

void generateExp(std::vector<double> &xs, std::vector<double> &ys, unsigned long n){
	for(unsigned long i = 0; i < n; i++){
		xs[i] = i * 1.0 / n;
		ys[i] = exp(xs[i]);
	}
}

// Randomly test for n points in range [0, 1]
void testExp(unsigned long n){
	srand(0);
	std::vector<double> xs(N), ys(N);
	generateExp(xs, ys, N);
	Interpolation *tp = new NewtonInterpolation(xs, ys);
	for(unsigned long i = 0; i < n; i++){
		double x = (double)rand() / RAND_MAX;
		std::cout << "x = " << x << std::endl;
		std::cout << "GT  : " << exp(x) << std::endl;
		std::cout << "Pred: " << tp->compute(x) << std::endl;
	}
	std::cout << "Done!" << std::endl;
}

int main(){
//	testExp(8);
    NewtonInterpolation nip({0.4, 0.5, 0.6}, {-0.916291, -0.693147, -0.510826});
    std::cout << nip.compute(0.54) << std::endl;
	return 0;
}
