function [fx, dx, hx] = func_l08(x)
% Function to calculate:
%          f(x1, x2) = exp(x1 + 3*x2) + exp(x1 - 3*x2) + exp(-x1);
% A little different from the textbook version(9.3.2), but the optimal 
% point is the same. The suffix `_l08` is just to avoid using simple 
% names like `func`.
%
% Arguments
% ---------
% 
% Returns
% -------
% fx     : function value at x
% dx     : gradient
% hx     : the Hessian matrix
%
a = [1, 3]';
b = [1, -3]';
c = [-1, 0]';
A = [a';, b';, c'];
t = exp(A*x);
fx = sum(t);
dx = A'*t;
hx = A' * bsxfun(@(x, y)x.*y, t, A);
end
