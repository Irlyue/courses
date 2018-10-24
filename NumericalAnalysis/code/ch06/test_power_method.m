n = 4;
A = randn(n);
lt = eigs(A, 1);
l = power_method(A, randn(n, 1), 1000);

fprintf('lambda_true = %8.4f\n', lt);
fprintf('lambda      = %8.4f\n', l);
