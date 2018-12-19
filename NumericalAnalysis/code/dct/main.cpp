#include"dct.h"
#include<iostream>
#include<algorithm>
#include<cstdlib>
#include<iomanip>

void test1d(){
	Matrix x({0, 0, 2, 2, 2, 2, 0, 0});
	x = x.transpose();
	Matrix xh = dct(x);
	cout << "x_hat = Cx\n";
	cout << xh.transpose() << endl;
	cout << "x = C'x_hat\n";
	cout << idct(xh).transpose() << endl;
}

void test2d(){
	Matrix x({
		{63, 33, 36, 28, 63, 81, 86, 98},
		{27, 18, 17, 11, 22, 48, 104, 108},
		{72, 52, 28, 15, 17, 16, 47, 77},
		{132, 100, 56, 19, 10, 9, 21, 55},
		{187, 186, 166, 88, 13, 34, 43, 51},
		{184, 203, 199, 177, 82, 44, 97, 73},
		{211, 214, 208, 198, 134, 52, 78, 83},
		{211, 214, 208, 198, 134, 52, 78, 83},
	});
	Matrix xh = dct2d(x), xx = idct2d(xh);
	cout << xh << endl;
	cout << xx << endl;
	setHalf2Zero(xh);
	xx = idct2d(xh);
	cout << xx << endl;
	cout << "Run the python script to see the difference visually." << endl;
}

int main(){
	test1d();
	test2d();
	return 0;
}

