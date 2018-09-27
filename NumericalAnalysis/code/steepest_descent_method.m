function [x, values] = steepest_descent_method(x0, A, p, n_steps)
% Parameters
% ----------
% -x0: the initial starting point
% -A, p: giving the function f(x) = 0.5x'Ax - p'x, A must a positive
% definite symmetric matrix.
% -n_steps: number of iterations, note sometimes it's not the actual number
% of iterations performed since we will stop iterating when the gradient
% almost reaches zero to avoid numerical problem.

% Returns
% -------
% -x: the solution for Ax = p
% -values: the function values f(x) at each step.

x = x0;
values = zeros(n_steps, 1);
for i = 1:n_steps
    r = A*x - p;
    % if the derivative is towards zero, just break;
    if r'*r <= 1e-8
        values = values(1:i-1);
        break;
    end
    alpha = -(r'*r) / ((A*r)'*r);
    x = x + alpha.*r;
    values(i) = 0.5.*x'*A*x - p'*x;
end

end

