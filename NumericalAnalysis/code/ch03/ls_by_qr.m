function [x] =  ls_by_qr(A, b, qr_transform)
% Solve the Least Square problem by QR decomposition
%
% Perform QR decomposition
%     ==> A = Q * [R]
%                 [0]
%     ==> Q'Ax =Q'Q * [R] * x = [Rx] = [Qb1]
%                     [0]       [0]    [Qb2]
% Denote c = Qb1, then all we need to solve is the new  linear system:
%            Rx = c
% Since R is an upper triangular matrix, we could solve the linear system
% more efficiently.
%
% Arguments
% ---------
% A             : matrix with shape(m, n), m >= n, feature matrix
% b             : target vector with shape(m, 1)
% qr_transform  : function object, when call return the new linear system
%                 in which Rx = c,
%                        [R, c] = qr_transform(A, b)
%
% Returns
% -------
% x    : the solution that minimizes the objective ||Ax - b||_2

[R, c] = qr_by_householder(A, b);
x = step(dsp.UpperTriangularSolver, R, c);

end
