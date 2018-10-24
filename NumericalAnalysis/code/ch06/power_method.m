function [mu, x] = power_method(A, x, n_iters)
% Use power method to calculate the absolute maximum eigenvalue and 
% one of its eigenvector.
%
% Arguments
% ---------
% A      : the matrix
% x      : intitial value
% n_iters: number of iterations
%
% Returns
% -------
% mu    : A's absolute maximum eigenvalue
% x     : eigenvector


for k = 1:n_iters
	y = A*x;
	mu = max_abs_element(y);
	x = y ./ mu;
end

function [a] = max_abs_element(x)
[~, idx] = max(abs(x));
a = x(idx);
