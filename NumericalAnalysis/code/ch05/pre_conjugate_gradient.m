function [x, step] = pre_conjugate_gradient(x, A, b, M, epsilon);
% Preconditioned conjugate gradient method
%
% Arguments
% ---------
% x        : initial value
% A, b     : Ax = b
% M        : preconditioned matrix
% epsilon  : scalar, a float number very close to 0.0, say 1e-7
%
% Returns
% -------
% x     : the answer for Ax = b
% step  : scalar, number of steps to reach x

if nargin == 4
    epsilon = 1e-10;
end

n = length(A);
step = 0;
r = b - A*x;
while step < n && sqrt(r'*r) > epsilon
	z = M \ r;
	if step == 0
		p = z;
		rou_new = r'*z;
	else
		rou = rou_new;
		rou_new = r'*z;
		beta = rou_new / rou;
		p = z + beta * p;
	end
	w = A * p;
	alpha = rou_new / (p'*w);
	x = x + alpha * p;
	r = r - alpha * w;
	step = step + 1;
end
