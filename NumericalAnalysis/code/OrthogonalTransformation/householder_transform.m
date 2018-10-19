function [y] = householder_transform(x, beta, v)
% This function calculates the Householder transformation
%
% Arguments
% ---------
% x          : vector or matrix
% beta, v    : this two values give the Householder matrix H = I - beta.*v*v'
%
% Returns
% -------
% y       : y = Hx

[m, n] = size(x);
if beta == 0
    y = x;
else
	y = zeros(m, n);
	for k = 1:n
		c = beta .* (x(:, k)' * v);
		y(:, k) = x(:, k) - c .* v;
	end
end

end
