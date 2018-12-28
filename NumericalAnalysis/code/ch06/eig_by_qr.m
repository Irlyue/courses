function [evalues] = eig_by_qr(A, n_iters)
% Use QR decomposition to compute the eigvalues of matrix.
%
% Algorithm:
% 1. Perform iteration
%       A_{k} = QR; 
%       A_{k+1} = RQ;
% 2. From 1), we obtain the real Schur decomposition R of the original
% matrix, which looks something like
%         [[R11   R12   R13   R14   R15]
%          [0     R22   R23   R24   R25]
%          [0     0     R33   R34   R35]
%          [0     0     0     R44   R45]
%          [0     0     0     0     R55]]
% where R_{ii} is either a real number (namely one of the eigen values),
% or it's a 2 by 2 matrix whose eigvalues are two of the conjugate
% eigvalues of A.
% 3. Obtain the eigen values from R.
%
% Arguments
% ---------
% A         : the matrix
% n_iters   : number of iterations
%
% Returns
% -------
% evalues   : the eigen values of matrix

if nargin == 1
	n_iters = 100;
end
for i = 1:n_iters
	[qrA, d] = my_qr(A);
	[q, r] = split_into_qr(qrA, d);
	A = r * q;
end
evalues = calc_eigvalues(A);

function [evalues] = calc_eigvalues(A)
n = length(A);
evalues = zeros(n, 1);
i = 1;
while i <= n
	if i == n || abs(A(i, i+1)) < 1e-10
		evalues(i) = A(i, i);
		i = i + 1;
	else
		[v1, v2] = calc_2x2eig(A(i:i+1, i:i+1));
		evalues(i) = v1;
		evalues(i+1) = v2;
		i = i + 2;
	end
end

function [u, v] = calc_2x2eig(A)
% This function computes the eigvalues of a 2 by 2 matrix.
a = A(1, 1);
b = A(1, 2);
c = A(2, 1);
d = A(2, 2);

delta = sqrt((a+d)^2 - 4*(a*d-b*c));
u = ((a+d)+delta)/2.;
v = ((a+d)-delta)/2.;
