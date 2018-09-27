function [beta, v] = calc_householder_matrix(x)
% Calculate the Houlseholder matrix(H) that mirrors x to first axis, where H = I - beta * vv';

n = numel(x);
x = x / max(x);
v = ones(n, 1);
v(2:end) = x(2:end);
alpha = x(2:end)' * x(2:end);
beta = 0.0;
if alpha ~= 0
    x_norm = sqrt(x(1)*x(1) + alpha);
    if x(1) < 0
        v(1) = x(1) - x_norm;
    else
        v(1) = -alpha / (x(1) + x_norm);
    end
    beta = 2 * v(1)^2 / (v(1)^2 + alpha);
    v = v / v(1);
end;