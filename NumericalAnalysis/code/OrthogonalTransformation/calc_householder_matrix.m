function [beta, v] = calc_householder_matrix(x)
% Calculate the Householder matrix such that
%       Hx = ||x||e1
% Arguments
% ---------
% x: vector to be transformed to x1 axis
%
% Returns
% -------
% beta, v: this two values determine the Householder matrix H = I - beta.*v*v'

n = numel(x);
x = x / max(abs(x));
v = ones(n, 1);
v(2:end) = x(2:end);
alpha = x(2:end)' * x(2:end);
beta = 1 - sign(x(1));   % There is bug in the implementation from the book where beta is set to 0.0
if alpha ~= 0
    x_norm = sqrt(x(1)*x(1) + alpha);
    if x(1) <= 0
        v(1) = x(1) - x_norm;
    else
        v(1) = -alpha / (x(1) + x_norm);
    end
    beta = 2 * v(1)^2 / (v(1)^2 + alpha);
    v = v / v(1);
end;
