#ifndef INTERP_H
#include<vector>

using DVector = std::vector<double>;

double polyF(const DVector &, double);
double polyDf(const DVector &, unsigned long);

class Interpolation{
protected:
    DVector xs;
    DVector ys;
public:
	virtual double compute(double) = 0;
	virtual void preCompute() = 0;
	Interpolation(const DVector & txs, const DVector &tys): xs(txs), ys(tys){}
};

class LagrangeInterpolation: public Interpolation{
private:
	DVector wxs;
	void preCompute() override;
public:
	LagrangeInterpolation(const DVector &, const DVector &);
	double compute(double) override;
};


class NewtonInterpolation: public Interpolation{
private:
	std::vector<DVector> dq;
	void preCompute() override;
public:
	NewtonInterpolation(const DVector &, const DVector &);
	double compute(double) override;
};

#endif
