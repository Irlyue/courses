function [x, his] = gradientDescent(x0, alpha, f, df, n_steps)
% x0: initial point
% alpha: scalar, fix learning rate
% f: function object to compute f(x)
% df: gradient function to compute df(x)
% n_steps: number of iterations

if nargin == 4
	n_steps = 50;
end

x = x0;
his = zeros(n_steps, 1);
for k = 1:n_steps
	x = x - alpha * df(x);
	his(k) = f(x);
end
