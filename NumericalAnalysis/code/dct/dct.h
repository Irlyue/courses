#ifndef DCT_H
#define DCT_H
#include<vector>
#include<cmath>
#include<iostream>
using namespace std;

using DVector = vector<double>;

const double PI = acos(-1.0);

class Matrix{
private:
	int m, n;
	vector<DVector> A;
public:
	int getM()const{return m;}
	int getN()const{return n;}
	Matrix(int pn);
	Matrix(int pm, int pn);
	Matrix(const DVector &dv);
	Matrix(const vector<DVector> &v);
	Matrix transpose()const;
	DVector &operator[](int i);
	friend Matrix operator*(const Matrix &lhs, const Matrix &rhs);
	friend ostream &operator<<(ostream &out, const Matrix &mt);
	friend bool operator==(const Matrix &lhs, const Matrix &rhs);
	friend void setHalf2Zero(Matrix &mt);
};

Matrix dct(const Matrix &x);
Matrix idct(const Matrix &xh);
Matrix dct2d(const Matrix &x);
Matrix idct2d(const Matrix &xh);

Matrix getC(int n);


#endif
