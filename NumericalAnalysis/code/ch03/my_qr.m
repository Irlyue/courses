function [A, d] = my_qr(A)
% QR refactorization
%
% Arguments
% ---------
% A: matrix with shape(m, n), m>=n
%
% Returns
% -------
% res: something like this,
%   [[r11, r12, r13],
%    [v12, r22, r23],
%    [v13, v23, r33],
%    [v14, v24, v34],
%    [v15, v25, v35]]
% 

[m, n] = size(A);
d = zeros(n, 1);
for k = 1:n
	[beta, v] = calc_householder_matrix(A(k:m, k));
	A(k:m, k:n) = householder_transform(A(k:m, k:n), beta, v);
	d(k) = beta;
	A(k+1:m, k) = v(2:end);
end

end
