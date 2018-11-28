#include"interp.h"
#include<algorithm>

LagrangeInterpolation::LagrangeInterpolation(const std::vector<double> &tx,
		const std::vector<double> &ty): xs(tx), ys(ty), wxs(tx.size()){
	preCompute();
}

void LagrangeInterpolation::preCompute(){
	for(unsigned long i = 0; i < xs.size(); i++){
		wxs[i] = polyDf(xs, i);
	}
}

double LagrangeInterpolation::compute(double x){
	double ans = 0.;
	double wnx = polyF(xs, x);
	for(unsigned long i = 0; i < xs.size(); i++){
		ans += ys[i] * wnx / ((x - xs[i]) * wxs[i]);
	}
	return ans;
}

// compute w(x) = (x - x0)(x - x1)...(x - xn)
double polyF(const std::vector<double> &xs, double x){
	double y = 1;
	for(unsigned long i = 0; i < xs.size(); i++){
		y *= x - xs[i];
	}
	return y;
}

// compute w'(xi) = (x-x0)...(x-x_i-1)(x-x_i+1)...(x-xn)
double polyDf(const std::vector<double> &xs, unsigned long idx){
	double y = 1.;
	for(unsigned long i = 0; i < xs.size(); i++){
		y *= (i == idx ? 1 : xs[idx] - xs[i]);
	}
	return y;
}
