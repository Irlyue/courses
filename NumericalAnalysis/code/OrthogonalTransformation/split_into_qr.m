function [q, r] = split_into_qr(A, d)
% <<WARNING>>
% Maybe not the most efficient code.
%
% Arguments
% ---------
%
% Returns
% -------
% q, r: 

[m, n] = size(A);
q = eye(m, m);
r = triu(A);

for k = 1:n
	v = A(k:m, k);
	v(1) = 1;
	h = blkdiag(eye(k-1), eye(m-k+1) - d(k).*v*v');
	q = q * h;
end
