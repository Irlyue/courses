#ifndef INTERP_H
#include<vector>

double polyF(const std::vector<double>&, double);
double polyDf(const std::vector<double>&, unsigned long);


class LagrangeInterpolation{
private:
	std::vector<double> xs;
	std::vector<double> ys;
	std::vector<double> wxs;
	void preCompute();
public:
	LagrangeInterpolation(const std::vector<double>&, const std::vector<double>&);
	double compute(double);
};

#endif
