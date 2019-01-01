#include"interp.h"
#include<algorithm>

LagrangeInterpolation::LagrangeInterpolation(const DVector &txs,
		const DVector &tys): Interpolation(txs, tys), wxs(txs.size()){
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
double polyF(const DVector &xs, double x){
	double y = 1;
	for (double xi : xs) {
		y *= x - xi;
	}
	return y;
}

// compute w'(xi) = (x-x0)...(x-x_i-1)(x-x_i+1)...(x-xn)
double polyDf(const DVector &xs, unsigned long idx){
	double y = 1.;
	for(unsigned long i = 0; i < xs.size(); i++){
		y *= (i == idx ? 1 : xs[idx] - xs[i]);
	}
	return y;
}

NewtonInterpolation::NewtonInterpolation(const DVector &txs,
		const DVector &tys): Interpolation(txs, tys), dq(xs.size()){
	preCompute();
}

void NewtonInterpolation::preCompute(){
	int n = ys.size();
	for(auto y: ys) dq[0].push_back(y);
	for(int i = 1; i < n; i++){
		for(int j = 0; j < n - i; j++){
			double q = (dq[i-1][j+1] - dq[i-1][j])/(xs[i+j] - xs[j]);
			dq[i].push_back(q);
		}
	}
}

double NewtonInterpolation::compute(double x){
	double ans = ys[0], t = 1;
	int n = ys.size();
	for(int i = 1; i < n; i++){
		t *= (x - xs[i-1]);
		ans += dq[i][0] * t;
	}
	return ans;
}
