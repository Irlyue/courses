function [x, k] = pre_conjugate_gradient(x0, A, b, M, epsilon);
% Preconditioned conjugate gradient method
%
% Arguments
% ---------
% x0       : initial value
% A, b     : Ax = b
% M        : preconditioned matrix
% epsilon  : scalar, a float number very close to 0.0, say 1e-7
%
% Returns
% -------
% x     : the answer for Ax = b
% k     : scalar, number of steps to reach x

if nargin == 4
    epsilon = 1e-7;
end

x = x0;
r = 0;
z = 0;
p = 0;
rou = 0;
k = 0;
while true
	k = k + 1;
	[x, r, z, p, rou] = move_one_step(x, A, b, M, r, z, p, rou, k == 1);
	if r' * r < epsilon
		break
	end
end


function [xnext, rnext, znext, pnext, rounext] = move_one_step(x, A, b, M, r, z, p, rou, first)
if first
	r = b - A*x;
	z = M \ r;
	rou = r'*z;
	p = z;
end
w = A * p;
alpha = rou / (p'*w);
xnext = x + alpha * p;
rnext = r - alpha * w;
znext = M \ rnext;
rounext = rnext' * znext;
beta = rounext / rou;
pnext = znext + beta * p;
