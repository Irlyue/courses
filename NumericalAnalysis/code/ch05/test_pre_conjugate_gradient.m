clear;
epsilon = 1e-9;
n = 5;
A = zeros(n, n);
%b = randn(n, 1);
b = ones(n, 1);
x0 = zeros(n, 1);

for k = 1:n
	A(k, k) = 2;
	if k < n
		A(k, k+1) = -3;
		A(k+1, k) = -3;
	end
end
big = diag((randi([0, 2], n, 1) - 1) * 100);
%A = A + big;

xt = A \ b;
[xgd, tgd] = conjugate_gradient(x0, A, b, epsilon);
fprintf('Conjugate gradient\n');
fprintf('step = %d, error = %.8f, norm(Ax-b)=%.8f\n', tgd, relative_error(xt, xgd), norm(A*xgd - b, 2));

M = diag(diag(A));
[xpgd, tpgd] = pre_conjugate_gradient(x0, A, b, M, epsilon);
fprintf('Pre-conditioned conjugate gradient\n');
fprintf('step = %d, error = %.8f, norm(Ax-b)=%.8f\n', tpgd, relative_error(xt, xpgd), norm(A*xpgd - b, 2));
