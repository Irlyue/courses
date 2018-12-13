#include"fft.h"
#include<cmath>


// Non-recursive implementation of Fast Fourier Transform.
// Calculate the results from bottom to the top.
vector<DComplex> my_fft_loop(const vector<DComplex> &ys){
	int n = ys.size();
	vector<DComplex> yh(n);
	vector<int> indices = getIndices(n);
	for(int i = 0; i < n; i++) yh[i] = ys[indices[i]];
	int i = 1;
	while(i < n){
		auto wk = calcWk(i);
		for(int j = 0; j < n; j += 2*i) calcRange(yh, j, i, wk);
		i *= 2;
	}
	return yh;
}

// Helper function for my_fft_recursive
void _my_fft_recursive(vector<DComplex> &ys){
	int N = ys.size() / 2;
	if(N == 1){
		auto tmp = ys[0] + ys[1];
		ys[1] = ys[0] - ys[1];
		ys[0] = tmp;
		return;
	}
	vector<DComplex> even(N);
	vector<DComplex> odd(N);
	// Pick out the even and odd elements
	fillEvery2(even, ys.cbegin(), N);
	fillEvery2(odd, ys.cbegin()+1, N);

	_my_fft_recursive(even);
	_my_fft_recursive(odd);

	auto wk = calcWk(N);
	for(int k = 0; k < N; k++){
		ys[k] = even[k] + wk[k] * odd[k];
		ys[k + N] = even[k] - wk[k] * odd[k];
	}
}

// Recursive implementation of Fast Fourier Transform
// Calculate the results from top to bottom
vector<DComplex> my_fft_recursive(const vector<DComplex> &ys){
	vector<DComplex> yh(ys);
	_my_fft_recursive(yh);
	return yh;
}

// Fill the target vector `dst` with every other element from `p`, repeat
// for `n` steps.
void fillEvery2(vector<DComplex> &dst, const_it p, int n){
	for(int i = 0; i < n; i++){
		dst[i] = *p;
		p++;
		p++;
	}
}

// Merge the even and odd part in to one.
//     even: [start, start + length)
//     odd:  [start + length, start + length*2)
void calcRange(vector<DComplex> &yh, int start, int length, const vector<DComplex> &wk){
	for(int k = 0; k < length; k++){
		// store the result in temporary memory since yh[k + start] is still
		// needed in the upcoming computation
		DComplex tmp = yh[k + start] + wk[k] * yh[k + start + length];
		yh[k + start + length] = yh[k + start] - wk[k] * yh[k + start + length];
		// remember to assign back the result
		yh[k + start] = tmp;
	}
}

// This function calculate those `wk` for equation:
//         y[k] = even + wk[k] * odd
// Mathematically, wk[k] = exp(-i*k*pi / N), where i*i = -1.
vector<DComplex> calcWk(int n){
	vector<DComplex> ans;
	for(int k = 0; k < n; k++){
		ans.push_back(exp(-1.0*k*CI*PI / (1.0*n)));
	}
	return ans;
}

// This function computes the swapped indices for the non-recursive implementation.
// Maybe not the most efficient implementation :), but simple enough.
//
// Take n = 8 for example,
// Begin:    [0 1 2 3 4 5 6 7]
// Swap 1:   [0 2 4 6 1 3 5 7]
// Swap 2:   [0 4 2 6 1 5 3 7]
// Returned the result [0 4 2 6 1 5 3 7]
vector<int> getIndices(int n){
	if(n == 2)
		return {0, 1};
	vector<int> indices(n);
	indices[0] = 0;
	indices[1] = 2;
	indices[2] = 1;
	indices[3] = 3;
	int i = 4;
	while(i < n){
		for(int j = 0; j < i; j++) {
			indices[j] *= 2;
			indices[j + i] = indices[j] + 1;
		}
		i *= 2;
	}
	return indices;
}
