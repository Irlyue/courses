function [A] = hessenberg(A)
% Hessenberg factorization. The final matrix after factorization is:
% [[* * * * *],
%  [* * * * *],
%  [0 * * * *],
%  [0 0 * * *],
%  [0 0 0 * *]]
% Here, we're using Householder matrix to perform orthogonal
% transformation.
%
% TODO When used with 1000 by 1000 matrix, this implementation is 
% pretty slow:). No idea why!
%
% Arguments
% ---------
% A     : n x n square matrix
% 
% Returns
% -------
% A     : Hessenberg matrix after factorization

n = length(A);

for k = 1:n-2
	[beta, v] = calc_householder_matrix(A(k+1:n, k));
	% H * A
	A(k+1:n, k:n) = householder_transform(A(k+1:n, k:n), beta, v);
    % A * H
	A(1:n, k+1:n) = householder_transform(A(1:n, k+1:n)', beta, v)';
end

end
