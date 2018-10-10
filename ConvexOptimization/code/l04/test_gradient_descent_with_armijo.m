clear;

m = 1000; n = 10;
A = randn(m, n);
A = A'*A;
b = randn(n, 1);

f = @(x)(0.5*x'*A*x - b'*x);
df = @(x)(A*x - b);

x0 = zeros(n, 1);
alpha = 1.0 / eigs(A, 1);
[x, his, t_his] = gradientDescentWithArmijo(x0, f, df);

xtrue = A \ b;
fprintf('Done in %d steps\n', numel(his));
disp(['xtrue = [', sprintf('%8.4f ', xtrue), ']'])
disp(['x     = [', sprintf('%8.4f ', x), ']'])
%plot(his);
