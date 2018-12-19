#include"dct.h"
#include<cassert>
#include<algorithm>

Matrix::Matrix(int pm, int pn): m(pm), n(pn), A(m){
	for(int i = 0; i < m; i++) {
		A[i].resize(n);
		fill_n(A[i].begin(), n, 0.);
	}
}

Matrix::Matrix(int pn): Matrix(pn, pn){}
Matrix::Matrix(const DVector &dv):m(1), n(dv.size()), A(m){
	A[0].resize(n);
	copy_n(dv.cbegin(), n, A[0].begin());
}

Matrix::Matrix(const vector<DVector> &v): m(v.size()), n(v[0].size()), A(m){
	for(int i = 0; i < m; i++){
		A[i].resize(n);
		copy_n(v[i].cbegin(), n, A[i].begin());
	}
}

Matrix operator*(const Matrix &lhs, const Matrix &rhs){
	assert(lhs.n == rhs.m);
	int m = lhs.m, l = lhs.n, n = rhs.n;
	Matrix x(m, n);
	for(int i = 0; i < m; i++){
		for(int j = 0; j < n; j++){
			for(int k = 0; k < l; k++) x.A[i][j] += lhs.A[i][k] * rhs.A[k][j];
		}
	}
	return x;
}

DVector &Matrix::operator[](int i){return A[i];}

bool operator==(const Matrix &lhs, const Matrix &rhs){
	if(lhs.m != rhs.m || lhs.n != rhs.n)
		return false;
	for(int i = 0; i < lhs.m; i++){
		for(int j = 0; j < rhs.m; j++){
			if(lhs.A[i][j] != rhs.A[i][j])
				return false;
		}
	}
	return true;
}

ostream &operator<<(ostream &out, const Matrix &mt){
	out << "[";
	for(int i = 0; i < mt.m; i++){
		out << (i == 0 ? "[" : " [");
		for(int j = 0; j < mt.n; j++)
			out << mt.A[i][j] << (j + 1 == mt.n ? "" : ", ");
		out << (i + 1 == mt.m ? "]]" : "]") << endl;
	}
	return out;
}

Matrix Matrix::transpose()const{
	Matrix mt(n, m);
	for(int i = 0; i < n; i++)
		for(int j = 0; j < m; j++)
			mt.A[i][j] = A[j][i];
	return mt;
}

Matrix dct(const Matrix &x){
	return getC(x.getM()) * x;
}

// Discrete Cosine Transform
Matrix idct(const Matrix &xh){
	return getC(xh.getM()).transpose() * xh;
}

Matrix dct2d(const Matrix &x){
	Matrix C = getC(x.getM());
	return C * (C * x).transpose();
}

Matrix idct2d(const Matrix &xh){
	Matrix C = getC(xh.getM());
	return (xh * C).transpose() * C;
}

void setHalf2Zero(Matrix &mt){
	assert(mt.m == mt.n);
	int m = mt.m;
	for(int i = 0; i < m; i++){
		for(int j = m-i-1; j < m; j++)
			mt.A[i][j] = 0.;
	}
}

// Get the transform matrix C where, x_hat = Cx
Matrix getC(int n){
	Matrix C(n);
	double a, b;
	for(int i = 0; i < n; i++){
		a = (i == 0 ? sqrt(1. / n) : sqrt(2. / n));
		for(int j = 0; j < n; j++){
			b = cos(PI * (2*j + 1) * i / (2*n));
			C[i][j] = a * b;
		}
	}
	return C;
}
