function [R, c] = qr_by_householder(A, b)
% Perform QR decomposition using the Householder transformation.
% 
% Arguments
% ---------
% A     : with shape(m, n)
% b     : with shape(m, 1), A and b defines the Least Square problem
%                    argmin_x ||Ax - b||_2
%
% Returns
% -------
% R : R is the upper triangular matrix in A = Q[R] and has shape(n, n).
%                                              [0]
% c : c obtained is by multiplying Q with b and retrieving the first n 
%     elements, so it has shape(n, 1).

[~, n] = size(A);
for i=1:n
	[beta, v] = calc_householder_matrix(A(i:end, i));
	A(i:end, i:end) = householder_transform(A(i:end, i:end), beta, v);
	b(i:end, 1) = householder_transform(b(i:end, 1), beta, v);
end

R = A(1:n, 1:n);
c = b(1:n, 1);