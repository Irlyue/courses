function [x, his] = is_newton_method_eq(x, v, A, b, f, n_iters, epsilon)
% Infeasible start Newton method with equalitiy constraint Ax=b.
% "is" stands for Infeasible Start.
%
% TODO add search logic for step size
%
% 
% Arguments
% ---------
% x      : initial x
% v      : initial v, Lagrange multiplier for Ax=b
% A, b   : equality constraint Ax=b
% f      : function object that computes function value, gradient and Hessian 
%          matrix, [fx, dx, hx] = f(x)
% n_iters: number of iterations
% epsilon: stopping criterion, ||r||_2 < epsilon, default to 1e-6
% 
% Returns
% -------
% x     : optimal point
% his   : history of the function value

if nargin == 6
	epsilon = 1e-6;
end

alpha = 1.0;
d = length(x);
r = length(v);
his = zeros(n_iters, 1);
for i = 1:n_iters
	[fx, dx, hx] = f(x);
	his(i) = fx;
	kkt = [hx, A'; A, zeros(r)];
	rhs = -[dx + A'*v; A*x - b];
	if norm(rhs) < epsilon
		his = his(1:i);
		break;
	end
	znt = kkt \ rhs;
	x = x + alpha * znt(1:d);
	v = v + alpha * znt(d+1:end);
end

end
