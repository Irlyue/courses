#include"fft.h"
#include<complex>
#include<iostream>
#include<ctime>
#include<string>

using namespace std;

using func_type = vector<DComplex> (const vector<DComplex>&);

void testMethod(func_type func, const vector<DComplex> &ys, string desc){
	clock_t tic = clock();
	func(ys);
	clock_t toc = clock();
	double elapsed = double(toc - tic) / CLOCKS_PER_SEC;
	cout << "Method " << desc << " done in " << elapsed << " seconds" << endl;
}

double diff(const vector<DComplex> &a, const vector<DComplex> &b){
	double ans = -1.0;
	for(unsigned long i = 0; i < a.size(); i++){
		auto d = a[i] - b[i];
		double l = sqrt(d.real()*d.real() + d.imag()*d.imag());
		ans = ans > l ? ans : l;
	}
	return ans;
}

int main(){
	int n = 1 << 20;
	vector<DComplex> ys;
	for(int i = 0; i < n; i++) ys.push_back(i % 5);
	cout << "n = " << n << endl;
	testMethod(my_fft_loop, ys, "loop version");
	testMethod(my_fft_recursive, ys, "recursive version");
	cout << diff(my_fft_loop(ys), my_fft_recursive(ys)) << endl;
	return 0;
}
