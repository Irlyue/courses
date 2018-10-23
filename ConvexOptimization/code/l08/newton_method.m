function [x, his] = newton_method(x, fobj, n_iters, epsilon)
% Newton method with armijo rule to search step size
%
% Arguments
% ---------
% x        : starting point
% fobj     : function object that calculates function value, gradient and Hessian
%		     matrix at x:
%		             [fx, dx, hx] = fobj(x)
% n_iters  : number of iterations
% epsilon  : stopping criterion for 0.5*dx'*(Hx \ dx) <= epsilon

if nargin == 3
	epsilon = 1e-8;
end

his = zeros(n_iters, 1);
for i = 1:n_iters
	[fx, dx, hx] = fobj(x);
	his(i) = fx;
	d = -hx \ dx;
	lambda = -0.5 * d' * dx;
	if lambda < epsilon
		his = his(1:i);
		break
	end
	alpha = armijoRule(x, dx, d, @(x)fobj(x), 0.1, 0.7);
	x = x + alpha * d;
end
