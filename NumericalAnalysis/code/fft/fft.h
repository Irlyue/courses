#ifndef FFT_H
#define FFT_H

#include<vector>
#include<complex>
#include<cmath>
using namespace std;

using DComplex=complex<double>;
using const_it=vector<DComplex>::const_iterator;
const double PI = acos(-1.0);

constexpr DComplex CI(0, 1);

vector<DComplex> my_fft_loop(const vector<DComplex> &ys);

vector<DComplex> my_fft_recursive(const vector<DComplex> &ys);

static vector<int> getIndices(int n);
static void calcRange(vector<DComplex> &yh, int start, int length, const vector<DComplex> &wk);
static vector<DComplex> calcWk(int n);
static void fillEvery2(vector<DComplex> &dst, const_it pstart, int n);

#endif
