function [x, step] = conjugate_gradient(x, A, b, epsilon)
% Use conjugate gradient method to solve linear system Ax = b.
%
% Arguments
% ---------
% x       : initial value
% A, b    : Ax = b
% epsilon : scalar, a float number very close to 0, say 1e-7
%
% Returns
% -------
% x      : the answer for Ax = b
% step   : scalar, number of steps to reach x.

if nargin == 3
    epsilon = 1e-10;
end

n = length(A);
step = 0;
r = b - A*x;
rou_new = r'*r;
while step < n && sqrt(rou_new) > epsilon
    if step == 0
        p = r;
    else
        beta = rou_new / rou_old;
        p = r + beta * p;
    end
    Ap = A*p;
    alpha = (r'*p) / (p'*Ap);
    x = x + alpha * p;
    r = r - alpha * Ap;
    rou_old = rou_new;
    rou_new = r'*r;
    step = step + 1;
end
