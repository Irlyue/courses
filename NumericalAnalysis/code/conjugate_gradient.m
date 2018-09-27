function [x, step] = conjugate_gradient(x0, A, b, epsilon)
% Use conjugate gradient method to solve linear system Ax = b.
% Arguments
% ---------
% x0: initial value
% A, b: Ax = b
% epsilon: scalar, a float number very close to 0, say 1e-7
%
% Returns
% -------
% x: the answer for Ax = b
% step: scalar, number of steps to reach x.

if nargin == 3
    epsilon = 1e-7;
end

x = x0;
r0 = 0;
r1 = 0;
p = 0;
step = 0;
while true
    [x, r1, r0, p] = move_one_step(x, A, b, r1, r0, p, step==0);
    if r1' * r1 < epsilon
        break
    end
    step = step + 1;
end


function [xnext, rnext, r, p] = move_one_step(x, A, b, r, rprev, pprev, first)
if first
    r = b - A*x;
    p = r;
else
    beta = (r' * r) / (rprev' * rprev);
    p = r + beta.*pprev;
end
t = A * p;
alpha = (r' * p) / (p' * t);
xnext = x + alpha.*p;
rnext = r - alpha.*t;
