% This script compares different methods to solve the Least Square problem:
%            argmin_x ||Ax - b||_2
% where A = USV' and its elements are:
%       [[k/sqrt(2) + 1/2.        -k/sqrt(6) + sqrt(3)/2.],
%        [   -k/sqrt(2)                   k/sqrt(6)      ],     
%        [k/sqrt(2) - 1/2.        -k/sqrt(6) - sqrt(3)/2.]]
% b = [3, 2, -1]';

U = [[1./sqrt(3), 1./sqrt(2)]; ...
    [-1./sqrt(3), 0.]; ...
	[1./sqrt(3), -1./sqrt(2)]];
V = [[sqrt(3)/2., 1./2]; ...
    [-1/2., sqrt(3)/2]];
S = [[sqrt(2), 0.]; ...
    [0., sqrt(2)]];
b = [3, 2, -1]';
xt = [1., sqrt(3)]';  % True value x*.


ks = [1e5, 1e7, 1e9];

lu_rs = zeros(3, 1);
qr_rs = zeros(3, 1);

disp([sprintf('%28s LU        QR', '')]);
for i=1:length(ks)
	k = ks(i);
	S(1, 1) = sqrt(2) * k;
	A = U*S*V';
	ATA = A'*A;
	ATb = A'*b;

	% Use Gaussian Elimination(LU).
	[l, u] = lu(ATA);
	y = step(dsp.LowerTriangularSolver, l, ATb);
	rs1 = step(dsp.UpperTriangularSolver, u, y);
	e1 = norm(rs1 - xt);

	% Use QR decomposition.
	rs2 = ls_by_qr(A, b, @qr_by_householder);
	e2 = norm(rs2 - xt);

	disp(['k = ', sprintf('%.e   ||x-x*||_2   %.8f  %f', k, norm(rs1-xt), norm(rs2-xt))]);
	disp(['    ', sprintf('%5s   r(x)         %.8f  %f', '',  norm(A*rs1-b), norm(A*rs2-b))]);
end
